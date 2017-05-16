#!/bin/bash
cd "${0%/*}"
echo "Logging into $1 as $2";

qrCodePath="/2fa.jpg";
qrCodePath=$1$qrCodePath;
./2fa-key-gen.py -i $qrCodePath > 2fa.txt
echo -n "2fa code is ";
cat 2fa.txt;
./screen-starter.sh $1 $2 $3;
rm 2fa.txt;
cd -;