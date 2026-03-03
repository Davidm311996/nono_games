#!/bin/bash

# Build the Flutter web project
echo "Building Flutter web..."
flutter build web --release

# Copy build results to root for Cloudflare deployment
echo "Deploying built files to root..."
cp -r build/web/* .

# Disable service worker (known to cause blank white page issues)
echo "Disabling service worker in flutter_bootstrap.js..."
perl -i -0777 -pe 's/_flutter\.loader\.load\(\{.*?\}\);/_flutter.loader.load({});/sg' flutter_bootstrap.js

echo "Done! You can now commit and push the updated files to GitHub."
echo "Ensure Cloudflare Pages is configured to serve from the ROOT directory (.)."
