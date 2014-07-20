#!/usr/bin/python
import fileinput
import httplib2
from xml.dom import minidom
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
suffix="dc=opends,dc=com"
LDAPStrategy="opends"
POST_URL = "https://localhost:8089/services/admin/LDAP-groups/" 
suffix.rstrip('\n')
for line in fileinput.input ("/Users/ithangasamy/scripts/ldif/AD_Automation_DelGroups100.ldif"):
#for line in fileinput.input ("./data/opends-dns-local.txt"):
#for line in fileinput.input ("./data/del.ad.ldif.txt"):
    CountryCode=randomLine("./data/countrycodes.txt")
    line = line.replace("\n","")
    print "dn:", line
    print "changetype:modify"
    print "replace:description"
    print "description:",CountryCode
    print ""
