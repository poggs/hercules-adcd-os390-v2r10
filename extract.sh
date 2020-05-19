#!/bin/bash
#
#  Extract DASD images from OS/390 ADCD archive
#

extractImage() {
  echo "Extracting image #$1"
  mkdir ISO$1
  cd ISO$1
  7z x ../IBM_ADCD_OS390_V2R10_CD$1of13_OS390RA0$1.iso # > /dev/null
  cd ..
}

extractVolume() {
  echo "Extracting $2 from ISO$1"
  cd DASD
  7z e ../ISO$1/OS390/$3.ZIP # > /dev/null
  cd ..
}

#echo "Uncompressing archive"
#unzip OS390_V2R10_ADCD.zip > /dev/null

echo "Extracting files from ISO images"
for img in 01 02 03 04 05 06 07 08 09 10 11 12 13
do
  extractImage $img
done

echo "Extracting DASD images"
mkdir DASD

extractVolume 01 "first RES volume" OS39RA
extractVolume 02 "second RES volume" OS3RAA
extractVolume 03 "second part of OS390DA volume 5" OS39DA_2
extractVolume 03 "service volume" OS39M1
extractVolume 04 "HFS" OS39HA
extractVolume 05 "DLIB volume 1" OS39DA
extractVolume 06 "DLIB volume 2" OS3DAA
extractVolume 07 "DLIB volume 3" OS3DAB
extractVolume 08 "database product volume (DB/2)" OS39PA
extractVolume 09 "CICS volume" OS3PAA
extractVolume 10 "IMS database products" OS3PAB
extractVolume 11 "component broker" OS3PAC
extractVolume 12 "WebSphere" OS3PAD

