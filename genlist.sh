#!/bin/sh

rm update.conf
wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O gfw.tmp
wget https://hg.adblockplus.org/easylistchina/raw-file/tip/easylistchina.txt -O adb.list
wget https://raw.githubusercontent.com/JinsongVan/chinalist/master/china_mobile_list.txt -O china_mobile.list

cat gfw.tmp |base64 -d >> gfw.list
cat gfw.list |grep -E '^\|\|[^/*]*$' | sed 's/|//g' | awk '{ print "gfw/"$1 }' >> update.tmp
cat adb.list |grep -E '^\|\|[^/*]*\^$' | sed 's/|//g' | sed 's/\^//g' | awk '{ print "adb/"$1 }' >> update.tmp
cat china_mobile.list |grep -E '^\|\|[^/*]*\^$' | sed 's/|//g' | sed 's/\^//g' | awk '{ print "adb/"$1 }' >> update.tmp

cat my.conf >>update.tmp
sed 's/adb\/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*//g' update.tmp > a.tmp
sed 's/gfw\/[0-9]*\/[0-9]*\.[0-9]*\.[0-9]*//g' a.tmp > b.tmp
sed '/^\s*$/d' b.tmp > c.tmp
cat c.tmp | awk '{ print $1 }' | sort | uniq >> update.conf

rm -f *.tmp *.list

