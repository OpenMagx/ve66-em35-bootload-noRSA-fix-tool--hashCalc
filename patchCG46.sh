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



# Detect CG by size
echo "> Code group: CG46 (lang)\n>	Alignment length"
dd if=/dev/zero count=1 bs=$(( 0x0be1800 - `stat -c '%s' $1` )) | tr '\000' '\377' >> $1



echo ">	Calc hash"
$mypath/calcHash $1 $mypath"hash.bin"

echo ">	Write hash"
cat $mypath"hash.bin" >> $1


echo ">	Recovery table of CG46"
cat $mypath"table_CG46.bin" >> $1


echo ">	Remove hash-file"
rm $mypath"hash.bin"

echo "> $1 patced!"
