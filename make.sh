#!/bin/bash
set -eu

LICENSE_NAME="${LICENSE_NAME:-"Your Name"}"
LICENSE_COMPANY="${LICENSE_COMPANY:-"Your Company Inc."}"
LICENSE_EMAIL="${LICENSE_EMAIL:-"your@email.com"}"
LICENSE_PLAN="${LICENSE_PLAN:-ultimate}"
LICENSE_USER_COUNT="${LICENSE_USER_COUNT:-2147483647}"
LICENSE_EXPIRE_YEAR="${LICENSE_EXPIRE_YEAR:-2500}"

cd "$(dirname "$0")"

BUILD_DIR=$(pwd)/build
mkdir -p "$BUILD_DIR"

echo "[*] generating key pair..."
./src/generator.keys.rb \
    --public-key "$BUILD_DIR/public.key" \
    --private-key "$BUILD_DIR/private.key"

echo "[*] generating license..."
./src/generator.license.rb \
    --public-key "$BUILD_DIR/public.key" \
    --private-key "$BUILD_DIR/private.key" \
    -o "$BUILD_DIR/result.gitlab-license" \
    --license-name "$LICENSE_NAME" \
    --license-company "$LICENSE_COMPANY" \
    --license-email "$LICENSE_EMAIL" \
    --license-plan "$LICENSE_PLAN" \
    --license-user-count "$LICENSE_USER_COUNT" \
    --license-expire-year "$LICENSE_EXPIRE_YEAR" \
    --plain-license "$BUILD_DIR/license.json"

echo ""
echo "-------------------------- PUBLIC KEY --------------------------"
cat "$BUILD_DIR/public.key"
echo "----------------------------------------------------------------"
echo ""
echo "----------------------- LICENSE KEY ------------------------"
cat "$BUILD_DIR/result.gitlab-license"
echo "------------------------------------------------------------"
echo ""
echo "[*] done $(basename "$0")"
