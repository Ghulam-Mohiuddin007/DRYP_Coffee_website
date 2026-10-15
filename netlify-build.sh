#!/usr/bin/env bash
set -e

echo "=== Netlify Flutter Web Build ==="

# Check if Flutter SDK is cached, otherwise clone stable channel
if [ ! -d "flutter" ]; then
  echo "Downloading Flutter SDK (stable channel)..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 flutter
else
  echo "Flutter SDK found in cache."
fi

# Add Flutter to PATH
export PATH="$PATH:$(pwd)/flutter/bin"

echo "Using Flutter:"
flutter --version

echo "Fetching dependencies..."
flutter pub get

echo "Compiling Flutter Web for Netlify..."
flutter build web --release --base-href "/"

echo "Build complete! Output is in build/web"
