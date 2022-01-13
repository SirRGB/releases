#!/bin/bash
mkdir "${WORKSPACE}/../ota"
cd "${WORKSPACE}/../ota"
rm -rf ota_config
git clone git@github.com:SirRGB/ota_config -b lineage-16.0
cd ota_config
echo ""
echo -n '{"response":['>hammerhead.json
echo -n {\"datetime\": \"`basename ${BUILD_START}`\",\"filename\": \"`basename ${finalzip_path}`\",\"id\": \"`sha256sum ${finalzip_path} | awk '{ print $1 }'`\",\"romtype\": \"unofficial\",\"size\": `stat -c%s ${finalzip_path}`,\"url\": \"https://github.com/${release_repo}/releases/download/${tag}/${zip_name}\",\"version\": \"16.0\"}>>hammerhead.json
echo ']}'>>hammerhead.json
git add .
git commit -m "hammerhead: push ota update"
git push origin lineage-16.0
echo ""
