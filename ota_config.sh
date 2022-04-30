#!/bin/bash
mkdir "${WORKSPACE}/../ota"
cd "${WORKSPACE}/../ota"
rm -rf ota_config
cd ota_config
echo ""
echo -n '{"response":['> "${device}.json"
echo -n {\"datetime\": \"`basename ${BUILD_START}`\",\"filename\": \"`basename ${finalzip_path}`\",\"id\": \"`sha256sum ${finalzip_path} | awk '{ print $1 }'`\",\"romtype\": \"unofficial\",\"size\": `stat -c%s ${finalzip_path}`,\"url\": \"https://github.com/${release_repo}/releases/download/${tag}/${zip_name}\",\"version\": \"16.0\"} >> '${device}.json'
echo ']}'>>"${device}.json"
echo ""
