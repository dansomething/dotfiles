#!/usr/bin/env bash
size=$((340 * 2048))
diskutil erasevolume HFS+ 'JDKRAMDISK' `hdiutil attach -nomount ram://$size`
cp -r  $(/usr/libexec/java_home -v 1.8) /Volumes/JDKRAMDISK
