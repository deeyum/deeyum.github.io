#!/bin/bash
res=''
for i in `ls _posts/*.md`; do
	funkytag=`cat $i|sed -n '/---/,/---/p'|grep '^ '`;
	if [ $? -eq 0 ]; then
		echo "Post $i has funky tags";
		tagstr='tags: ['
		tagstr+=`cat $i|sed -n '/---/,/---/p'|grep '^ '|awk '{print $2}'|paste -sd,`;
		tagstr+=']\n';
		res+=$tagstr
	else
		res+=`grep 'tags:' $i`;
		res+="\n";
	fi
done
for tag in `echo -e $res|cut -d '[' -f2|cut -d ']' -f1|tr -d '[ ]'|tr '\r\n' ',' |tr -s ','|tr ',' '\n'|sort -u`; do
	echo "Checking for tag $tag";
	if [ -s tag/$tag.md ]; then
		#echo "Tag $tag exists, so skipping.";
		continue;
	else
		echo "Tag $tag not found, so creating";
		cp tag/template.md tag/$tag.md
		sed -i "s/template/$tag/" tag/$tag.md;
	fi
done
