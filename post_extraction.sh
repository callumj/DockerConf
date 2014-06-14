#!/bin/bash
for BaseName in *; do
  `busan "${BaseName}/Dockerfile"`
done