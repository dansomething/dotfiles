#!/usr/bin/env bash

VERSION=8
MEMORY=160
JDK_PATH="/Volumes/JDK${VERSION}RAMDISK"

if [ ! -d "$JDK_PATH" ]; then
  size=$((MEMORY * 2000))
  path=$(/usr/libexec/java_home -v 1.$VERSION)
  # shellcheck disable=SC2046
  diskutil erasevolume HFS+ "JDK${VERSION}RAMDISK" $(hdiutil attach -nomount ram://$size)
  rsync -a --exclude=*src.zip --exclude=man --exclude=visualvm "$path" "$JDK_PATH"
  ln -s "$path"/src.zip "$JDK_PATH"/Home
fi

export JAVA_HOME="$JDK_PATH/Home"
unset JDK_PATH
