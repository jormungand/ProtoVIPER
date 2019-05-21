#!/bin/bash

## symlink the templates to "~/Library/Developer/Xcode/Templates/File Templates/ProtoVIPER"

_tplDir="${HOME}/Library/Developer/Xcode/Templates/File Templates"
_targetDir="${_tplDir}/ProtoVIPER"

mkdir -p "${_targetDir}"
echo "Linking templates:"


find "${PWD}" -iname "*.xctemplate" | while read _tpl; do
	_tplBasename="$( basename "${_tpl}" )"

	echo "* ${_tpl} --> ${_targetDir}/${_tplBasename}"
	ln -sf "${_tpl}"   "${_targetDir}/${_tplBasename}"
done

echo
