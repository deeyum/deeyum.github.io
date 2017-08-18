#!/bin/bash
res=''
for i in `ls _posts/*.md`; do
	res+=`grep 'tags:' $i`;
	res+="\n";
done
for tag in `echo -e $res|cut -d '[' -f2|cut -d ']' -f1|tr -d '[ ]'|tr '\r\n' ',' |tr -s ','|tr ',' '\n'|sort -u`; do
	echo "Checking for tag $tag";
	if [ -s tag/$tag.md ]; then
		continue;
	else
		echo "Tag $tag not found, so creating";
		cp tag/template.md tag/$tag.md
		sed -i "s/template/$tag/" tag/$tag.md;
	fi
done
