#!/usr/bin/env bash 
diskutil erasevolume HFS+ 'JDKRAMDISK' `hdiutil attach -nomount ram://716800`
cp -r  $(/usr/libexec/java_home -v 1.8) /Volumes/JDKRAMDISK
