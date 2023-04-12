#!/bin/bash

## This script is called to copy all ressources
## Destination is basicly the output/ module
## The output module is the document-root of what is served on deployment

mkdir -p output/img

## app files
cp sources/ressources/img/* output/img/

cp sources/ressources/favicon/* output/
cp sources/ressources/manifest/* output/
cp sources/ressources/jsworker/* output/

echo 0
