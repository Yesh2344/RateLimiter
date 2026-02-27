#!/bin/bash

# Test the get_current_time function
CURRENT_TIME=$(get_current_time)
if [ -z $CURRENT_TIME ]; then
    echo "Error: get_current_time function returned empty value"
    exit 1
fi

# Test the get_time_remaining function
RESET_TIME=$(get_current_time)
WINDOW=60
TIME_REMAINING=$(get_time_remaining $(get_current_time) $RESET_TIME $WINDOW)
if [ -z $TIME_REMAINING ]; then
    echo "Error: get_time_remaining function returned empty value"
    exit 1
fi