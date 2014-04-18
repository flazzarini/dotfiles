import urllib.request
import json

url = "http://mixer.gefoo.org/playing"
req = urllib.request.Request(url, None)

# Read response
resp = urllib.request.urlopen(req).readall().decode('utf-8')

if json.loads(resp):
    res = json.loads(resp)
    print("{0} - {1}".format(res['artist'],
                             res['title']))
