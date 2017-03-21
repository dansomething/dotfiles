#!/usr/bin/env bash

JDK_PATH="/Volumes/JDKRAMDISK"

if [ ! -d "$JDK_PATH" ]; then
  size=$((340 * 2048))
  # shellcheck disable=SC2046
  diskutil erasevolume HFS+ 'JDKRAMDISK' $(hdiutil attach -nomount ram://$size)
  cp -r "$(/usr/libexec/java_home -v 1.8)" "$JDK_PATH"
fi

export JDK_HOME="$JDK_PATH/Home"
unset JDK_PATH
