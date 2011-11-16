#!/bin/sh

#
# Add to CG36 and CG46 SHA1 hash and table 
# Writed for Motorola VE66/EM35 with NoRSA Boot by yakk
#
# Writed by Ant-ON
# Metod by yakk
#

myfile=`basename $0`
mypath=`echo $0 | sed -e 's/'$myfile'//g'`

lang=0

# Detect CG by size
if [ `stat -c '%s' $1` > 0x1A000 ]
then
echo "> Code group: CG36 (rootfs)\n>	Alignment length"
dd if=/dev/zero count=1 bs=$(( 0x3e63800 - `stat -c '%s' $1` )) | tr '\000' '\377' >> $1
else
echo "> Code group: CG46 (lang)\n>	Alignment length"
dd if=/dev/zero count=1 bs=$(( 0x0be1800 - `stat -c '%s' $1` )) | tr '\000' '\377' >> $1
lang=1
fi

echo ">	Calc hash"
$mypath/calcHash $1 $mypath"hash.bin"

echo ">	Write hash"
cat $mypath"hash.bin" >> $1

if [ $lang -eq 0 ] 
then
echo ">	Recovery table of CG36"
cat $mypath"table.bin" >> $1
else
echo ">	Recovery table of CG46"
cat $mypath"table_CG46.bin" >> $1
fi

echo ">	Remove hash-file"
rm $mypath"hash.bin"

echo "> $1 patced!"
