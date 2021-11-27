#!/bin/bash
echo "Sync started for ${manifest_url}/tree/${branch}"
if [ "${jenkins}" == "true" ]; then
    telegram -i ${RELEASES_DIR}/assets/sync1.png -M "Sync started for [${ROM} ${ROM_VERSION}](${manifest_url}/tree/${branch}): [See Progress](${BUILD_URL}console)"
else
    telegram -i ${RELEASES_DIR}/assets/sync1.png -M "Sync started for [${ROM} ${ROM_VERSION}](${manifest_url}/tree/${branch})"
fi
SYNC_START=$(date +"%s")
if [ "${official}" != "true" ]; then
    rm -rf .repo/local_manifests
    mkdir -p .repo/local_manifests
    wget "${local_manifest_url}" -O .repo/local_manifests/manifest.xml
fi
if [ -z ${referencedir} ]; then
    echo "referencedir is not set. Sync will happen completely dependant on your Internet connection."
    repo init -u "${manifest_url}" -b "${branch}" --depth 1
else
    echo "Taking ${referencedir} as reference for existing checkouts."
    echo "Be aware that manifests using different configuration style (e.g. lineage on reference and laos on current for LineageOS) won't take each other as reference!"
    repo init -u "${manifest_url}" -b "${branch}" --depth 1 --reference "${referencedir}"
fi
cores=$(nproc --all)
if [ "${cores}" -gt "8" ]; then
    cores=8
fi
repo sync --force-sync --fail-fast --no-tags --no-clone-bundle --optimized-fetch --prune "-j${cores}" -c -v
syncsuccessful="${?}"
SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
if [ "${syncsuccessful}" == "0" ]; then
    echo "Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
    telegram -i ${RELEASES_DIR}/assets/sync3.png -N -M "Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
    source "${my_dir}/build.sh"
else
    echo "Sync failed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
    telegram -i ${RELEASES_DIR}/assets/sync2.png -N -M "Sync failed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
    curl --data parse_mode=HTML --data chat_id=$TELEGRAM_CHAT --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TELEGRAM_TOKEN/sendSticker
    exit 1
fi
