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
for line in fileinput.input ("titles.txt"):
    URL_PARAM=''
    line = line.replace("\n","")
    #line = line.replace(" ","%20")
    GroupName=str(line).rstrip(" ")+" Administrator"
    print "GroupName.rstrip", GroupName
#for key in dic.iterkeys():
    URL_PREFIX = LDAPStrategy +","+GroupName
    #surl =   "dn: cn=%s,ou=groups,%s\nobjectclass:top\nobjectclass:groupofnames\n" % (GroupName,suffix)
    for i in range(3):
        role_s=randomLine("roles.txt")
        URL_PARAM += "&roles=" + "splunk_role_"+ role_s
        #print "URL_PARAM=",URL_PARAM
    URL_PARAM=URL_PARAM +"&roles=user"
    POST_DATA=URL_PARAM
#POST_DATA=urllib.urlencode(URL_PARAM)
#POST_DATA=urllib.quote(URL_PARAM)
    URL_PREFIX=urllib.quote(URL_PREFIX)
    URL1=POST_URL+URL_PREFIX
    print "surl=%s and URL_PARAM=%s and URLPREFIX=%s"%(URL1,POST_DATA,URL_PREFIX)
    serverContent = httplib2.Http(disable_ssl_certificate_validation=True)
    serverContent.add_credentials('admin','changeme')
    print "URL1=",URL1
    resp,content=serverContent.request(URL1 ,
                      'POST', 
                      headers={}, 
                      body=POST_DATA)
                      #body=urllib.urlencode({'roles':'admin','roles':'can_delete'}))
#resp=serverContent.getresponse()
#serverContent.set_debuglevel(5)
    print resp.status
    print content
    #assert resp.status == 200
