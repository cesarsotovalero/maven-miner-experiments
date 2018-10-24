#!/bin/bash

SCRIPT_NAME=$0

function print_usage_and_exit {
  echo "Usage: $SCRIPT_NAME"
  echo "--path            The path to store resulting CSV files"
  echo "--neo4j-home      The absolute path to Neo4j"
  exit 1
}

CURR=`pwd`
while [[ $# > 1 ]]
do
key="$1"
shift
case $key in
    --path)
    PATH_CSV=$1
    shift
    ;;
    --neo4j-home)
    NEO4J=$1
    shift
    ;;
    *)
    print_usage_and_exit
    ;;
esac
done

if [ -z "$PATH_CSV" ] || [ -z "$NEO4J" ]; then
  echo "Missing arguments, please see usage below!"
  print_usage_and_exit
fi

cd $NEO4J
sed -e "s#%PATH%#$PATH_CSV#g" $CURR/test.cypher | bin/cypher-shell --format plain
