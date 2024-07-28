#!/bin/bash
cd ${ROM_DIR}_ota/
echo ""
echo ""
echo -n '{"response":['>${device}.json
echo -n {\"datetime\": \"`basename ${BUILD_START}`\",\"filename\": \"`basename ${finalzip_path}`\",\"id\": \"`sha256sum ${finalzip_path} | awk '{ print $1 }'`\",\"romtype\": \"UNOFFICIAL\",\"size\": `stat -c%s ${finalzip_path}`,\"url\": \"https://github.com/${release_repo}/releases/download/${tag}/${zip_name}\",\"version\": \"${ROM_VERSION}\"}>>${device}.json
echo ']}'>>${device}.json
cat ${device}.json
echo ""
echo ""

git add .
git commit -m "${device}: push automatic ota update"
git push origin ${branch}
