#!/bin/bash

# GitHub token and organization name
GITHUB_TOKEN="XXXXXX"  # Ensure SSO is authorized for the organization
ORG_NAME="XXXXXX"

# Function to fetch and list all repositories with workflows containing a specific string
list_repositories_with_workflows_app() {
    local query="uses: docker"  # Search string
    local page=1
    local per_page=100
    local repos
    local total_count=0

    echo "Fetching repositories for organization: $ORG_NAME"

    while :; do
        repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
            "https://api.github.com/orgs/$ORG_NAME/repos?per_page=$per_page&page=$page" | jq -r '.[].name')

        if [ -z "$repos" ]; then
            break
        fi

        for repo in $repos; do
            echo "Processing repository: $repo"

            # Get list of workflow files
            workflows=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
                "https://api.github.com/repos/$ORG_NAME/$repo/contents/.github/workflows" | jq -r '.[].path' 2>/dev/null)

            if [ -n "$workflows" ]; then
                for workflow in $workflows; do
                    # Fetch workflow content
                    response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
                        "https://api.github.com/repos/$ORG_NAME/$repo/contents/$workflow")

                    # Check if response contains valid content
                    content=$(echo "$response" | jq -r '.content // empty')

                    if [ -z "$content" ]; then
                        echo "No content found for $workflow in $repo"
                        continue
                    fi

                    # Decode Base64 content
                    decoded_content=$(echo "$content" | tr -d '\n' | base64 --decode 2>/dev/null)

                    if [ $? -ne 0 ] || [ -z "$decoded_content" ]; then
                        echo "Error decoding base64 content for $workflow in $repo"
                        continue
                    fi

                    # Search for the query in the decoded content
                    if echo "$decoded_content" | grep -q "$query"; then
                        echo "Workflows-app found:"
                        echo "Repository: $repo"
                        echo "Workflow: $workflow"
                        total_count=$((total_count + 1))
                    fi
                done
            fi
        done

        ((page++))
    done

    echo "Total repositories with workflows-app: $total_count"
}

# Run function
list_repositories_with_workflows_app
