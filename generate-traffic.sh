#!/bin/bash

# Nginx Traffic Generator Script for Mac
echo "Starting nginx traffic generation..."
echo "Press Ctrl+C to stop"

# Counter for requests
counter=0

# Function to generate random traffic
generate_traffic() {
    # Array of endpoints to hit
    endpoints=(
        "/"
        "/api/success"
        "/api/error"
        "/api/not-found"
        "/slow"
        "/nonexistent"
        "/admin"
    )
    
    # Array of user agents
    user_agents=(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
        "curl/7.79.0"
        "PostmanRuntime/7.29.2"
        "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X)"
    )
    
    while true; do
        # Pick random endpoint
        endpoint=${endpoints[$RANDOM % ${#endpoints[@]}]}
        
        # Pick random user agent  
        user_agent=${user_agents[$RANDOM % ${#user_agents[@]}]}
        
        # Make request
        curl -s -H "User-Agent: $user_agent" "http://localhost:8080$endpoint" > /dev/null
        
        counter=$((counter + 1))
        echo "Request #$counter sent to $endpoint"
        
        # Random sleep between 1-3 seconds
        sleep $((1 + RANDOM % 3))
    done
}

# Start generating traffic
generate_traffic