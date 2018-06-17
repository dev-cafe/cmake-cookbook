#!/usr/bin/env bash

BINARY=$1

OUTPUT=$($BINARY 1 2 3 4)

if [ "$OUTPUT" = "10" ]
then
    exit 0
else
    exit 1
fi
