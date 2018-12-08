#!/bin/sh

rm update.conf
wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O gfw.tmp
wget https://hg.adblockplus.org/easylistchina/raw-file/tip/easylistchina.txt -O adb.list

cat gfw.tmp |base64 -d >> gfw.list
cat gfw.list |grep -E '^\|\|[^/*]*$' | sed 's/|//g' | awk '{ print "gfw/"$1 }' >> update.tmp
cat adb.list |grep -E '^\|\|[^/*]*\^$' | sed 's/|//g' | sed 's/\^//g' | awk '{ print "adb/"$1 }' >> update.tmp
cat update.tmp | awk '{ print $1 }' | sort | uniq >> update.conf

rm -f gfw.tmp update.tmp gfw.list adb.list

