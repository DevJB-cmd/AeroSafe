#!/bin/bash
# AEROSAFE - Verification and Setup Script

echo "🛫 AEROSAFE - Complete Application Verification"
echo "================================================"
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Flutter installation
echo "📋 Checking prerequisites..."
if command -v flutter &> /dev/null; then
    echo -e "${GREEN}✓${NC} Flutter installed: $(flutter --version | head -1)"
else
    echo -e "${RED}✗${NC} Flutter not found. Please install Flutter."
    exit 1
fi

if command -v dart &> /dev/null; then
    echo -e "${GREEN}✓${NC} Dart installed: $(dart --version)"
else
    echo -e "${RED}✗${NC} Dart not found."
    exit 1
fi

echo ""
echo "📦 Checking dependencies..."

# Check if pubspec.lock exists
if [ -f "pubspec.lock" ]; then
    echo -e "${GREEN}✓${NC} pubspec.lock found"
else
    echo -e "${YELLOW}⚠${NC} pubspec.lock not found. Running 'flutter pub get'..."
    flutter pub get
fi

echo ""
echo "🎯 Verifying project structure..."

# Check main directories
DIRS=("lib/core" "lib/presentation" "lib/routes" "lib/theme" "lib/widgets")
for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $dir exists"
    else
        echo -e "${RED}✗${NC} $dir missing"
    fi
done

echo ""
echo "📱 Verifying presentation screens..."

SCREENS=(
    "lib/presentation/splash_screen"
    "lib/presentation/home_screen"
    "lib/presentation/incident_selection"
    "lib/presentation/location_mapping"
    "lib/presentation/description_input"
    "lib/presentation/anonymous_chat_screen"
    "lib/presentation/admin_authentication"
    "lib/presentation/admin_dashboard_screen"
    "lib/presentation/qr_access_screen"
    "lib/presentation/settings_screen"
)

for screen in "${SCREENS[@]}"; do
    if [ -d "$screen" ]; then
        echo -e "${GREEN}✓${NC} $(basename $screen) exists"
    else
        echo -e "${RED}✗${NC} $(basename $screen) missing"
    fi
done

echo ""
echo "🔧 Verifying core services..."

if [ -f "lib/core/services/anonymous_message_service.dart" ]; then
    echo -e "${GREEN}✓${NC} AnonymousMessageService exists"
else
    echo -e "${RED}✗${NC} AnonymousMessageService missing"
fi

echo ""
echo "✨ All checks completed!"
echo ""
echo "🚀 To run the application:"
echo "   flutter run -d chrome          (Web)"
echo "   flutter run -d android         (Android Emulator)"
echo "   flutter run -d ios             (iOS Simulator)"
echo ""
echo "🔐 Admin Login Code: 9209258291098652 (16 digits)"
echo ""
