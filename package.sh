#!/bin/sh

name=${PWD##*/}
version=$(awk '/^## Version:/ {print $3}' $name.txt)
git archive --format zip -o $name-$version.zip --prefix $name/ @
