#!/bin/bash

# Simple deployment script
set -e

echo "🚀 Deploying AyuRadhi..."

# Stop services
pm2 delete all || true

# Install dependencies
npm run install-all

# Build applications
npm run build

# Start backend
cd backend
pm2 start server.js --name "api"

# Start frontend
cd ../frontend
pm2 serve build 3001 --name "frontend" --spa

# Start admin
cd ../admin
pm2 serve build 3000 --name "admin" --spa

# Save PM2 config
pm2 save

echo "✅ Deployment complete!"
pm2 list