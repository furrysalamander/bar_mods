#!/bin/sh
AUTH=$(echo -n "$OPENCODE_SERVER_USERNAME:$OPENCODE_SERVER_PASSWORD" | base64)
wget -q --spider --header "Authorization: Basic $AUTH" http://127.0.0.1:4096/global/health
