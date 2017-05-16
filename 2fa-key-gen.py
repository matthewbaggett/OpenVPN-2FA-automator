#!/usr/bin/env python
import qrtools
import pyotp;
import urlparse;

import subprocess;
import time;
import getopt;
import sys;

def main(argv):
   inputfile = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["ifile="])
   except getopt.GetoptError:
      print 'test.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print '2fa-key-gen.py -i <2fa_image>'
         sys.exit()
      elif opt in ("-i", "--ifile"):
         inputfile = arg
         calculate(arg);


def calculate(file_location):
	qr = qrtools.QR()
	qr.decode(file_location)
	o = urlparse.parse_qs(urlparse.urlsplit(qr.data).query);
	totp = pyotp.TOTP(o['secret'][0]);

	print(totp.now());


if __name__ == "__main__":
   main(sys.argv[1:])



