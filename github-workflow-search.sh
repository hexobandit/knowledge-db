#!/bin/bash

# GitHub token and organization name
GITHUB_TOKEN="XXXXXX"         # Make sure to authorize SSO to access the XXX organization,
ORG_NAME="XXXXXX"

# Function to fetch and list all repositories with workflows containing a specific string
string
list_repositories_with_workflows_app() {
    local query="uses: docker"                # <<< SEARCHING FOR "USES: DOCKER" WITHIN WORKFLOW
    local page=1
    local per_page=100
    local repos
    local total_count=0

    echo "Fetching repositories for organization: $ORG_NAME"

    while :; do
        repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/orgs/$ORG_NAME/repos?per_page=$per_page&page=$page" | grep -oP '"name": "\K[^"]+')
        if [ -z "$repos" ]; then
            break
        fi

        for repo in $repos; do
            echo "Processing repository: $repo"
            # Get list of workflow files
            workflows=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$ORG_NAME/$repo/contents/.github/workflows" | grep -oP '"path": "\K[^"]+')
            if [ -n "$workflows" ]; then
                for workflow in $workflows; do
                    # Check if the workflow file contains the query
                    content=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$ORG_NAME/$repo/contents/$workflow" | grep -oP '"content": "\K[^"]+')
                    if [ -z "$content" ]; then
                        echo "No content found for $workflow in $repo"
                        continue
                    fi
                    # Remove line breaks from the Base64 content
                    content=$(echo "$content" | tr -d '\n')
                    # Validate Base64 content
                    if ! [[ "$content" =~ ^[A-Za-z0-9+/]+={0,2}$ ]]; then
                        echo "Invalid Base64 content for $workflow in $repo"
                        continue
                    fi
                    # Add padding if necessary
                    while (( ${#content} % 4 )); do
                        content="${content}="
                    done
                    # Decode using openssl
                    decoded_content=$(echo "$content" | openssl base64 -d 2>/dev/null)
                    if [ $? -ne 0 ]; then
                        echo "Error decoding base64 content for $workflow in $repo"
                        continue
                    fi
                    if echo "$decoded_content" | grep -q "$query"; then
                        echo "Workflows-app found:"
                        echo "Repository: $repo"
                        echo "Workflows:"
                        echo "$workflow"
                        total_count=$((total_count + 1))
                    fi
                done
            fi
        done

        ((page++))
    done

    echo "Total repositories with workflows-app: $total_count"
}

# List all repositories with workflows containing "uses: hqy01/workflows-app"
list_repositories_with_workflows_app
