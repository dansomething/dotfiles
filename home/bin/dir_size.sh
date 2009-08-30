#!/bin/bash


files=`find . -maxdepth 1 -type d ! -name ".*"`

for file in $files;
do du -hs $file;
done;
