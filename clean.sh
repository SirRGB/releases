#!/bin/bash

export my_dir=$(pwd)

echo "Loading configuration..."
source "${my_dir}"/config.sh

if [ -z "${GITHUB_TOKEN}" ]; then
    echo "Please set GITHUB_TOKEN before continuing."
    exit 1
fi

# Email for git
git config --global user.email "${GITHUB_EMAIL}"
git config --global user.name "${GITHUB_USER}"

mkdir -p "${ROM_DIR}"
cd "${ROM_DIR}"
if [ -d "${ROM_DIR}/out" ]; then
make clean -j$(nproc --all)
make clobber -j$(nproc --all)
fi

if [ ! -d "${ROM_DIR}/.repo" ]; then
echo "Initializing repository..."
if [ -z ${referencedir} ]; then
    echo "referencedir is not set. Sync will happen completely dependant on your Internet connection."
    repo init -u "${manifest_url}" -b "${branch}" --depth 1
else
    echo "Taking ${referencedir} as reference for existing checkouts."
    echo "Be aware that manifests using different configuration style (e.g. lineage on reference and laos on current for LineageOS) won't take each other as reference!"
    repo init -u "${manifest_url}" -b "${branch}" --depth 1 --reference "${referencedir}"
fi
fi
source "${my_dir}"/sync.sh
