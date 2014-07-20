#!/usr/bin/python
import fileinput
import sys
import httplib2
import random
import urllib2
import urllib
import commands

def randomLine(filename):
	"Retrieve a  random line from a file, reading through the file once"
	fh = open(filename, "r")
	lineNum = 0
	it = ''

	while 1:
		aLine = fh.readline()
		lineNum = lineNum + 1
		if aLine != "":
			#
			# How likely is it that this is the last line of the file ? 
			if random.uniform(0,lineNum)<1:
				it = aLine
		else:
			break

	fh.close()

	return it.replace("\n","")
## end of http://code.activestate.com/recipes/59865/ }}}

dic = {}
MAX_SESSIONS=sys.argv[1]
#POST_URL = "https://10.0.2.15:8089/services/auth/login" 
POST_URL = "https://localhost:8089/services/auth/login" 
for i in range(1,int(MAX_SESSIONS)):
    line=randomLine("50kuids.csv")
    uid,pwd = line.split(":")
    #print "surl=%s and URL_PARAM=%s and URLPREFIX=%s"%(URL1,POST_DATA,URL_PREFIX)
    serverContent = httplib2.Http(disable_ssl_certificate_validation=True)
    resp,content=serverContent.request(POST_URL ,
                      'POST', 
                      headers={}, 
                      body=urllib.urlencode({'username':uid,'password':pwd}))
    #print resp.status
    #print content
    if resp.status != 200:
       print "Status Code: %s : Could not get token for user %s with passwd %s"%(resp.status,uid,pwd)
