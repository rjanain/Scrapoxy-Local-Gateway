#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Scrapoxy Setup...${NC}"

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}.env file not found. Creating from .env.example...${NC}"
    cp .env.example .env
    echo -e "${GREEN}.env created. Please edit it with your desired credentials.${NC}"
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker does not seem to be running. Please start Docker and try again."
    exit 1
fi

# Build and Run
echo -e "${GREEN}Building and starting containers...${NC}"
docker-compose up -d --build

echo -e "${GREEN}----------------------------------------------------------------${NC}"
echo -e "${GREEN}Scrapoxy is running!${NC}"
echo -e ""
echo -e "Commander GUI: ${YELLOW}http://localhost:8889${NC}"
echo -e "No-Auth Proxy: ${YELLOW}http://localhost:8890${NC}"
echo -e ""

if [ -f "scrapoxy-data/scrapoxy.json" ]; then
    echo -e "${GREEN}Existing project configuration found in scrapoxy-data/scrapoxy.json.${NC}"
    echo -e "${GREEN}Your project and proxies are restored.${NC}"
else
    echo -e "${YELLOW}IMPORTANT SETUP STEP (First Run Only):${NC}"
    echo -e "1. Go to http://localhost:8889 and log in."
    echo -e "2. Create a new Project."
    echo -e "3. Copy the 'Username' and 'Password' from the project dashboard."
    echo -e "4. Open the '.env' file and paste them into PROJECT_PROXY_USERNAME and PROJECT_PROXY_PASSWORD."
    echo -e "5. Run this script again to apply the changes."
fi

echo -e "${GREEN}----------------------------------------------------------------${NC}"
