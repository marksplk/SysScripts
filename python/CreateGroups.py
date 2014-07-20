#!/usr/bin/python
import fileinput
## {{{ http://code.activestate.com/recipes/59865/ (r1)
import random

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

	return it
## end of http://code.activestate.com/recipes/59865/ }}}

dic = {}
suffix="dc=opends,dc=com"
suffix.rstrip('\n')
f=open('/tmp/workfile', 'w')
s =   "dn: ou=groups," +suffix+ "objectclass:top\nobjectclass:organizationalunit\n\n"
f.write(s)
for line in fileinput.input ("titles.txt"):
    line = line.replace("\n","")
    GroupName=str(line)+" Administrator"
    print "GroupName.rstrip", GroupName
#for key in dic.iterkeys():
    s =   "dn: cn=%s,ou=groups,%s\nobjectclass:top\nobjectclass:groupofnames\n" % (GroupName,suffix)
    f.write(s)
    for i in range(1,20):
        memberdn=randomLine("50kuids.txt")
        line1 = "member:%s" %(memberdn)
        f.write(line1)
    f.write("\n")
f.close()
