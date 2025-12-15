# Generate native app icons for Android and iOS using flutter_launcher_icons

Write-Host "Running flutter pub get..."
flutter pub get

Write-Host "Generating app icons (flutter_launcher_icons)..."
flutter pub run flutter_launcher_icons:main

Write-Host "Done. If icons did not update, ensure assets/images/aerosafe_logo.png is a high-resolution square PNG (>=1024x1024)."