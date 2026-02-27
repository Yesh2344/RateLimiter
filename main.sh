#!/bin/bash

# Load configuration from .env file
if [ -f ".env" ]; then
    source .env
else
    echo "Please create a .env file from the example."
    exit 1
fi

# Set the rate limit and time window from the environment variables
LIMIT=$RATE_LIMIT
WINDOW=$TIME_WINDOW

# Initialize the rate limit counter and reset time
COUNTER=0
RESET=$(date +%s)

# Start the server
while true; do
    # Listen for incoming requests
    REQUEST=$(nc -l -p 8080 -c "echo")

    # Check if the request is a GET or POST
    if [[ $REQUEST =~ "GET" ]]; then
        # Handle GET request
        LIMIT_REMAINING=$((LIMIT - COUNTER))
        if [ $LIMIT_REMAINING -lt 0 ]; then
            LIMIT_REMAINING=0
        fi

        RESPONSE=$(jq -n --arg limit $LIMIT --arg remaining $LIMIT_REMAINING --arg reset $(date -d @$RESET +%s) '{limit: $limit, remaining: $remaining, reset: $reset}')
        echo "HTTP/1.1 200 OK"
        echo "Content-Type: application/json"
        echo ""
        echo "$RESPONSE"
    elif [[ $REQUEST =~ "POST" ]]; then
        # Handle POST request
        COUNTER=$((COUNTER + 1))
        if [ $COUNTER -gt $LIMIT ]; then
            # Rate limit exceeded, return 429 status code
            echo "HTTP/1.1 429 Too Many Requests"
            echo ""
        else
            LIMIT_REMAINING=$((LIMIT - COUNTER))
            if [ $LIMIT_REMAINING -lt 0 ]; then
                LIMIT_REMAINING=0
            fi

            RESPONSE=$(jq -n --arg limit $LIMIT --arg remaining $LIMIT_REMAINING --arg reset $(date -d @$RESET +%s) '{limit: $limit, remaining: $remaining, reset: $reset}')
            echo "HTTP/1.1 200 OK"
            echo "Content-Type: application/json"
            echo ""
            echo "$RESPONSE"
        fi
    fi

    # Check if the time window has passed and reset the counter
    CURRENT_TIME=$(date +%s)
    if [ $CURRENT_TIME -gt $RESET ]; then
        COUNTER=0
        RESET=$((CURRENT_TIME + WINDOW))
    fi
done