#!/bin/bash

# Function to get the current time in seconds
get_current_time() {
    date +%s
}

# Function to calculate the time remaining until the rate limit resets
get_time_remaining() {
    local current_time=$1
    local reset_time=$2
    local window=$3

    if [ $current_time -lt $reset_time ]; then
        echo $((reset_time - current_time))
    else
        echo $((window - (current_time - reset_time) % window))
    fi
}