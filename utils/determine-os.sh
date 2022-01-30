#!/usr/bin/env bash

# Sets flags for use in installation scripts


# MacOS uname: "Darwin"
# MacOS M1 uname -m: "arm64"
# MacOS Intel uname -m: "x86_64"

# Raspbian uname -m: "armv7l"

AUTO_DARWIN=false
AUTO_LINUX=false
AUTO_X86_64=false
AUTO_ARM=false
AUTO_ARM64=false

case "$(uname)" in
  'Linux')
    AUTO_OS='Linux'
    AUTO_LINUX=true
    ;;
  'Darwin') 
    OS='Darwin'
    AUTO_DARWIN=true
    ;;
  *) 
    ;;
esac

case "$(uname -m)" in
	'armv7l')
		AUTO_ARM=true
	;;
	'arm64')
		AUTO_ARM64=true
	;;
	'x86_64')
		AUTO_X86_64=true
	;;
	*)
	;;
esac

AUTO_DETERMINED=true
