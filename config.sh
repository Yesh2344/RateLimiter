#!/bin/bash

# Load configuration from .env file
if [ -f ".env" ]; then
    source .env
else
    echo "Please create a .env file from the example."
    exit 1
fi

# Set the rate limit and time window from the environment variables
RATE_LIMIT=$RATE_LIMIT
TIME_WINDOW=$TIME_WINDOW