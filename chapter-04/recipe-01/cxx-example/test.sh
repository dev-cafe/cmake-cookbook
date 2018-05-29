#!/usr/bin/env bash

OUTPUT=$(./sum_up 1 2 3 4)

if [ "$OUTPUT" = "10" ]
then
    exit 0
else
    exit 1
fi
