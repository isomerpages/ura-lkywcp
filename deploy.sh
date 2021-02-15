#!/bin/bash 

# search within all collections for collection.yml file
collections=$(find . -path ./_site -prune -false -o -name collection.yml -type f)

# recursively adds collection.yml file to build command
# https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
OIFS="$IFS"
IFS=$'\n'
for collection in $collections
do
 var="${var},${collection}"
done
IFS="$OIFS"

env='development'
while getopts "e:" opt; do
  case $opt in
    e) env=$OPTARG      ;;
    *) echo 'error' >&2
       exit 1
  esac
done

# netlify build
JEKYLL_ENV=$env jekyll build --config _config.yml"$var"

# uncomment for local build
# bundle exec jekyll serve --config _config.yml"$var"