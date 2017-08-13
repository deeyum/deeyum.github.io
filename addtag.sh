#!/bin/bash

fn() {

cat <<EOF
---
layout: default
title: template
---
{% include tag.html %}
EOF
}
while read ln; do 
	candidate=`echo $ln|sed 's/ /-/'`;
	if [ ! -f tag/$candidate.md ]; then
		echo "now creating tag $candidate";
		fn >tag/$candidate.md;
		sed -i "s/template/$candidate/" tag/$candidate.md;
	fi 
done <<EOF
wildlife
mammals
birds
birding
insects
thoughts
poetry
humour
photography
videos
children
families
kalyan
kavya
anjana
derek
cities
citizen matters
articles
travel
poetry
death
love
life
friends
bangalore
nature
scenery
lakes
rivers
karnataka
india
tamil nadu
surveys
flowers
plants
trees
caterpillars
seeds
EOF
