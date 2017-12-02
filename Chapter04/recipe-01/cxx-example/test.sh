#!/usr/bin/env bash

OUPUT=$(./sum_up 1 2 3 4)

if [ "$OUPUT" = "10" ]
then
    exit 0
else
    exit 1
fi
