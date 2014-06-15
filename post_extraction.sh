#!/bin/bash
for BaseName in *; do
  if [ -f "${BaseName}/Dockerfile" ]
  then
    busan "${BaseName}"
  fi
done