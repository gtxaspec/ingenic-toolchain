#!/bin/bash
local=`pwd`

repo forall -p -c "git log --pretty=oneline -1" > SOURCE
sed -i "s/^project src\///g" SOURCE
sed -i "s/^project //g" SOURCE
sed -i ':a;N;$!ba;s/\/\n/\/: /g' SOURCE
sed -i '/^[[:space:]]*$/d' SOURCE

pushd ../.repo/manifests
echo "manifest/: " `git log --pretty=oneline -1` >> ${local}/SOURCE
popd

mv SOURCE $local/../install/.SOURCE
