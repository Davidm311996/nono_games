#!/bin/bash

# Build the Flutter web project
echo "Building Flutter web..."
flutter build web --release

# Ensure public directory exists and is empty
echo "Cleaning public directory..."
rm -rf public
mkdir -p public

# Copy build results to public
echo "Copying build results to public/..."
cp -r build/web/* public/

# Disable service worker (known to cause blank white page issues)
echo "Disabling service worker in public/flutter_bootstrap.js..."
# Use perl for safe multi-line replacement in minified JS
perl -i -0777 -pe 's/_flutter\.loader\.load\(\{.*?\}\);/_flutter.loader.load({});/sg' public/flutter_bootstrap.js

echo "Done! You can now commit and push the 'public/' folder to GitHub."
echo "Ensure Cloudflare Pages is configured to serve from the 'public/' directory."
