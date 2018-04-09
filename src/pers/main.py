#!/usr/bin/env python

import sys
from threading import Timer
import socket

import json

python_version = float("%s.%s"%(sys.version_info.major,sys.version_info.minor))

if python_version >= 3.0:
        from urllib.request import urlopen as urlopen
else:
        import urllib2
        from urllib2 import urlopen





def end(code=0): sys.exit(code)

def handler(fh):
        fh.close()

def download(url):
        timeout = 10.0
        try:
                fh = urlopen(url, timeout = timeout)
        except urllib2.URLError as e:
                sys.stderr.write("\n%s\n"% str(e))
                return end(1)
        except ValueError as e:
                sys.stderr.write(str(e))
                return end(1)
        except urllib2.URLError as e:
                # For Python 2.6
                if isinstance(e.reason, socket.timeout):
                        log.error("Socket timeout")
                        return end(1)
                else:
                        # reraise the original error
                        raise
        except socket.timeout as e:
                # For Python 2.7
                log.error("Socket timeout")
                return end(1)

        t = Timer(timeout, handler,[fh])
        t.start()
        data = fh.read()
        t.cancel()
        return data

url = 'https://apiv2.bitcoinaverage.com/indices/local/ticker/BTCUSD'
if len(sys.argv) > 1: url = str(sys.argv[1:][0])


try:
        data = json.loads(download(url))
except ValueError as e:
        sys.stderr.write("\n%s\n" % str(e))
        end(1)

from pprint import pprint
pprint(dict(ask=data['ask'],bid=data['bid'],avg=data['averages']['day']))


