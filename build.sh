#!/bin/bash
SOURCE=pi_blocklist_porn_all.list
OUT=max_porn_block.list
UPSTREAM=https://raw.githubusercontent.com/chadmayfield/my-pihole-blocklists/master/lists/$SOURCE

mkdir -p lists
cd lists

if [ ! -f "$SOURCE" ]
then
    wget $UPSTREAM
else
    echo Chad Mayfield source already downloaded. Delete it to force refresh
fi

egrep "^[0-9,a-z,A-Z]*\..{2,7}$" $SOURCE |sed  's#^#www\.#' > enriched.list
cat $SOURCE enriched.list > $OUT

echo `wc -l $SOURCE` [entries in source list]
echo `wc -l enriched.list` [new entries]
echo `wc -l $OUT` [entries in final list]
rm enriched.list
