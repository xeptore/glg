#!/bin/bash
set -eu

LICENSE_NAME="${LICENSE_NAME:-"Your Name"}"
LICENSE_COMPANY="${LICENSE_COMPANY:-"Your Company Inc."}"
LICENSE_EMAIL="${LICENSE_EMAIL:-"your@email.com"}"
LICENSE_PLAN="${LICENSE_PLAN:-ultimate}"
LICENSE_USER_COUNT="${LICENSE_USER_COUNT:-2147483647}"
LICENSE_EXPIRE_YEAR="${LICENSE_EXPIRE_YEAR:-2500}"

cd "$(dirname "$0")"

echo '[*] generating key pair...'
./generator.keys.rb \
    --public-key public.key \
    --private-key private.key

echo '[*] generating license...'
./generator.license.rb \
    --public-key public.key \
    --private-key private.key \
    --output .gitlab-license \
    --license-name "$LICENSE_NAME" \
    --license-company "$LICENSE_COMPANY" \
    --license-email "$LICENSE_EMAIL" \
    --license-plan "$LICENSE_PLAN" \
    --license-user-count "$LICENSE_USER_COUNT" \
    --license-expire-year "$LICENSE_EXPIRE_YEAR" \
    --plain-license license.json

echo ""
echo "-------------------------- PUBLIC KEY --------------------------"
cat public.key
echo "----------------------------------------------------------------"
echo ""
echo "----------------------- LICENSE KEY ------------------------"
cat .gitlab-license
echo "------------------------------------------------------------"
echo ""
echo "[*] done $(basename "$0")"
