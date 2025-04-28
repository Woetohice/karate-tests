#!/bin/bash

# Default values
ENV="local"
TAGS=""
PROFILE=""

# Print usage information
print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -e, --env ENV       Set the environment (local, dev, qa, prod). Default: local"
    echo "  -t, --tags TAGS     Run tests with specific tags"
    echo "  -p, --profile PROFILE  Use specific Maven profile"
    echo "  -h, --help         Show this help message"
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--env)
            ENV="$2"
            shift 2
            ;;
        -t|--tags)
            TAGS="$2"
            shift 2
            ;;
        -p|--profile)
            PROFILE="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            ;;
    esac
done

# Validate environment
if [[ ! "$ENV" =~ ^(local|dev|qa|prod)$ ]]; then
    echo "Error: Invalid environment '$ENV'. Must be one of: dev, qa, prod"
    exit 1
fi

# Build the Maven command
MAVEN_CMD="mvn test -Dkarate.env=$ENV"

# Add tags if specified
if [ ! -z "$TAGS" ]; then
    MAVEN_CMD="$MAVEN_CMD -Dkarate.options=\"--tags $TAGS\""
fi

# Add profile if specified
if [ ! -z "$PROFILE" ]; then
    MAVEN_CMD="$MAVEN_CMD -P$PROFILE"
fi

# Print the command being executed
echo "Executing: $MAVEN_CMD"

# Execute the command
eval $MAVEN_CMD

# Check the exit status
if [ $? -eq 0 ]; then
    echo "Tests completed successfully"
else
    echo "Tests failed"
    exit 1
fi
