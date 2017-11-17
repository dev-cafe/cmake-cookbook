#!/usr/bin/env bash

OUPUT=$(./replicate 2 "hello echo")

if [ "$OUPUT" = "hello echo hello echo" ]
then
    exit 0
else
    exit 1
fi
