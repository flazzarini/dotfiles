import urllib2
import json

url = "http://mixer.gefoo.org/playing"
req = urllib2.Request(url, None)

# Read response
resp = urllib2.urlopen(req).read()

if json.loads(resp):
    res = json.loads(resp)
    print "{0} - {1}".format(res['artist'],
                             res['title'])
