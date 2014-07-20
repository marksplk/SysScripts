#!/usr/bin/env python

from urllib import urlencode
import httplib,sys
from Cookie import SimpleCookie

class HTTPConnection(object):
    def __init__(self, host, port=None):
        self.host = host
        self.port = port
        self.response = None
        self.cookies = SimpleCookie()
    
    def request(self, method, url, body=None, headers=None):
        h = httplib.HTTPConnection(self.host, self.port)

        headers = headers or {}
        cookies = []
        for cookie in self.cookies:
            cookies.append('{0}={1}'.format(cookie,
                                            self.cookies[cookie].coded_value))
        
        headers['cookie'] = '; '.join(cookies)

        h.request(method, url, body, headers)
        self.response = h.getresponse()
        
        self.cookies = SimpleCookie(self.response.getheader('set-cookie'))

uid=sys.argv[1]
pwd=sys.argv[2]
conn = HTTPConnection('sveserv50.sv.splunk.com:8000')
# Get cval, UID and session id
conn.request('GET', '/lzone/en-US/account/login')
assert conn.response.status == 200
# Fix the cval cookie, due to a bug in SimpleCookie a trailing , is present
conn.cookies['cval'] = conn.cookies['cval'].value[:-1]
data = {
    'username': uid,
    #'username': 'kavin',
    'password': pwd,
    #'password': 'secret12',
    'cval': conn.cookies['cval'].value
}
# Log in
conn.request('POST', '/lzone/en-US/account/login', body=urlencode(data),
             headers={'Content-Type': 'application/x-www-form-urlencoded'})
assert conn.response.status == 303

# We're now logged in, request whatever page you want
conn.request('GET', '/en-US/app/search/dashboard')
assert conn.response.status == 200
