from cStringIO import StringIO
import os, sys, time
import logging

import lxml.etree as etree

import splunk.clilib.cli
import splunk.clilib.cli_common
import splunk.clilib.control_exceptions as cex
import splunk.rest as rest

REPORT_MAX = 5

def fileStatus(args, fromCLI):
  paramsReq = ()
  paramsOpt = ("authstr", "clear", "interval")
  splunk.clilib.cli_common.validateArgs(paramsReq, paramsOpt, args)

  #### init ####
  XNS="http://www.w3.org/2005/Atom"
  SNS="http://dev.splunk.com/ns/rest"
  restPath = "/services/admin/inputstatus/TailingProcessor:FileStatus"
  fullStatusMsg = "For full status, visit:\n  %s%s\n" % (splunk.clilib.cli_common.getMgmtUri(), restPath)

  fetchedOnce = False
  shouldClearScreen = True
  clearScreen = splunk.clilib.cli_common.isWindows \
      and (lambda: os.system("cls")) or (lambda: os.system("clear"))

  #### args ####
  try:
    interval = "interval" in args and int(args["interval"]) or 1
  except ValueError:
    raise cex.ArgError, "interval takes a numeric argument."

  if "clear" in args:
    shouldClearScreen = splunk.clilib.cli_common.getBoolValue("clear", args["clear"])

  authStr = args["authstr"]
  tailDirsSeenLast    = 0
  tailDoneFilesLast   = 0

  #### main loop ####
  while True:
    if not fetchedOnce:
      sys.stderr.write("Fetching for the first time...");
    startTime = time.time()
    response, content = rest.simpleRequest(restPath, sessionKey=authStr, rawResult=True)

    if response.status < 200 or response.status > 299:
      if response.status in (401, 403):
        print "\n\nNeed to login (%d).\n" % response.status
        splunk.clilib.cli.login({}, fromCLI = True)
        authStr = splunk.clilib.cli.readAuthToken()
        continue
      raise Exception, str(content)

    fetchedOnce = True
    tree = etree.parse(StringIO(content))
    #print etree.tostring(tree)
    items = tree.getroot().findall(".//{%s}key[@name='inputs']/{%s}dict/{%s}key[@name]" % (SNS, SNS, SNS))

    tailDirsSeenNum    = 0 ### tailDirsSeen    = []
    tailDoneFilesNum   = 0 ### tailDoneFiles   = []
    tailErrorFiles     = {}
    tailErrorFilesNum  = {}
    ## tailInProgFiles = []
    tailOpenFiles      = {}
    tailWTFFiles       = []
    tailWTFFilesNum    = 0

    for item in items:
      path = str(item.attrib["name"])

      itemType = "unknown"
      tmp = item.find(".//{%s}key[@name='type']" % SNS)
      if None != tmp:
        itemType = tmp.text
      tmp = item.find(".//{%s}key[@name='percent']" % SNS)
      if None != tmp:
        try:
          percent = float(tmp.text)
        except ValueError:
          percent = 100 # i think we get invalid values sometimes when filesize=0.

      if itemType == "directory":
        tailDirsSeenNum += 1 ### tailDirsSeen.append(path)
      # also, we can go beyond 100% due to buggy reporting. :P
      # (itemType == "open file" and percent >= 100) or \
      elif itemType == "finished reading" or itemType == "done reading (batch)":
        tailDoneFilesNum += 1 ### tailDoneFiles.append(path)
      elif itemType == "open file" or itemType == "reading (batch)":
        tailOpenFiles[path] = percent
      ## # scanned doesn't appear to show up! :( FIXME
      ## elif itemType == "scanned" or 0 != itemType.count("batch"):
      ##   tailInProgFiles.append(path)
      elif itemType == "unknown":
        tailWTFFilesNum += 1
        if tailWTFFiles <= REPORT_MAX:
          tailWTFFiles.append(path)
      else:
        if not itemType in tailErrorFiles:
          tailErrorFiles[itemType] = []
          tailErrorFilesNum[itemType] = 0
        tailErrorFilesNum[itemType] += 1
        if tailErrorFilesNum[itemType] <= REPORT_MAX:
          tailErrorFiles[itemType].append(path)

    endTime = time.time()
    diffDirs  = tailDirsSeenNum - tailDirsSeenLast
    diffFiles = tailDoneFilesNum - tailDoneFilesLast

    if shouldClearScreen:
      clearScreen()
    else:
      print "----"

    print fullStatusMsg
    print "Updated: %s (took %.1f sec)" % (time.asctime(), endTime - startTime)
    print "Have seen %d dirs. (%s%s)" % (tailDirsSeenNum, (diffDirs >= 0) and "+" or "", diffDirs)
    print "Finished with %d tracked files. (%s%s)" % (tailDoneFilesNum, (diffFiles >= 0) and "+" or "", diffFiles)
    tailDirsSeenLast  = tailDirsSeenNum
    tailDoneFilesLast = tailDoneFilesNum
    print
    print "Currently reading %d files." % len(tailOpenFiles)
    if len(tailOpenFiles) > 0:
      print "  some open files (showing up to %d):" % REPORT_MAX
      for path, perc in tailOpenFiles.items()[:REPORT_MAX]:
        print "    %s \t(%g%%)" % (path, perc)
    print
    erroneousFiles = sum([tailErrorFilesNum[x] for x in tailErrorFilesNum])
    print "Ignoring %d items." % erroneousFiles
    if erroneousFiles > 0:
      print "  some of these files (showing up to %d per type):" % REPORT_MAX
      for errType, paths in tailErrorFiles.items():
        print "    %s:\n      %s" % (errType, str.join("\n      ", paths[:REPORT_MAX]))
    print
    if tailWTFFilesNum > 0:
      print "Have %d files waiting to be read.  If these filenames do not go away" % tailWTFFilesNum
      print "eventually, check splunkd.log for CRC conflict errors."
      if tailWTFFilesNum > 0:
        print "  some of these files (showing up to %d):" % REPORT_MAX
        print "    " + str.join("\n    ", tailWTFFiles[:REPORT_MAX])

    if 0 == interval:
      break

    time.sleep(interval)

def main():
  # hack our way into the CLI so we can get auth and stuff. :)
  splunk.clilib.cli.cList.addCmd(splunk.clilib.cli.SplunkCmd("_internal", "filestatus", fileStatus, authReq = True))
  args = ["splunk", "_internal", "filestatus"] + sys.argv[1:]

  # copied from cli.py, a bit of stuff is outside main().
  if splunk.clilib.cli.ARG_DEBUG in sys.argv or splunk.clilib.cli.ENV_DEBUG in os.environ:
    splunk.clilib.cli_common.debugMode = True
  if splunk.clilib.cli.ENV_URI in os.environ:
    splunk.clilib.cli_common.setUri(os.environ[splunk.clilib.cli.ENV_URI])
  
  # copied from cli.py, same as above.
  logging.raiseExceptions = 0
  logging.getLogger().setLevel(splunk.clilib.cli_common.debugMode and logging.DEBUG or logging.INFO)

  # run.
  return splunk.clilib.cli.main(args)

if __name__ == "__main__":
  try:
    while True:
      ret = main()
      if splunk.clilib.cli.ERR_SPLUNKD_DOWN == ret:
        sys.stderr.write("splunkd is down, retrying in 5 seconds...\n\n")
        time.sleep(5)
        continue
      break
  except KeyboardInterrupt:
    sys.stderr.write("\nKilled via Ctrl-C.\n")
