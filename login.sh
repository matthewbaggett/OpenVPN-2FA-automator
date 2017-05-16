#!/bin/bash
echo "Login: ${0%/*}"
cd "${0%/*}"
echo "Logging into $1 as $2";

qrCodePath="/2fa.jpg";
qrCodePath=$1$qrCodePath;
twofa=`./2fa-key-gen.py -i $qrCodePath`
echo  "2fa code is $twofa"
./screen-starter.sh $1 $2 $3 $twofa;
cd -;