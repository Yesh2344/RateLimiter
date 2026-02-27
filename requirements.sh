#!/bin/bash

# Check if bash is installed
if ! command -v bash &> /dev/null; then
    echo "Bash is not installed. Please install it and try again."
    exit 1
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install it and try again."
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install it and try again."
    exit 1
fi