#!/bin/bash
for BaseName in *; do
  if [[ -f "${BaseName}/Dockerfile" && ! "${BaseName}" =~ "busan" ]]
  then
    busan "${BaseName}"
  fi
done

if [[ -f "busanfiles-deploy/Dockerfile" ]]
then
  busan busanfiles-deploy
fi