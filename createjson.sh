#!/bin/bash
#put script in crDroid source folder, make executable (chmod +x createupdate.sh) and run it (./createupdate.sh)

#modify values below
#leave blank if not used
CR_VERSION="${ROM_VERSION}"

date="$(date +"%Y%m%d")"
maintainer="SirRGB" #ex: Lup Gabriel (gwolfu)
oem="OnePlus" #ex: OnePlus
device="cheeseburger" #ex: guacamole
devicename="OnePlus 5" #ex: OnePlus 7 Pro
zip="${zip_name}" #ex: crDroidAndroid-<android version>-<date>-<device codename>-v<crdroid version>.zip
buildtype="Monthly" #choose from Testing/Alpha/Beta/Weekly/Monthly
forum="https://t.me/OP5T_flos_crdroid_updates" #https link (mandatory)
gapps="" #https link (leave empty if unused)
firmware="https://sourceforge.net/projects/lineageos-cheeseburger/files/firmware/cheeseburger/firmware_10.0.1_cheeseburger.zip/download" #https link (leave empty if unused)
modem="" #https link (leave empty if unused)
bootloader="" #https link (leave empty if unused)
recovery="" #https link (leave empty if unused)
paypal="https://www.paypal.com/donate/?hosted_button_id=9C79NMF2T3366" #https link (leave empty if unused)
telegram="https://t.me/OP5T_flos_crdroid_updates" #https link (leave empty if unused)

#don't modify from here
script_path="${ROM_DIR}"
zip_name=$script_path/out/target/product/$device/$zip
buildprop=$script_path/out/target/product/$device/system/build.prop

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
zip_only=`basename "$zip_name"`
md5=`md5sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"`
version=`echo "$zip_only" | cut -d'-' -f5`
v_max=`echo "$version" | cut -d'.' -f1 | cut -d'v' -f2`
v_min=`echo "$version" | cut -d'.' -f2`
version=`echo $v_max.$v_min`
download=`echo https://github.com/${release_repo}/releases/tag/${tag}`

echo ""
echo '{
  "response": [
    {
        "maintainer": "'$maintainer'",
        "oem": "'$oem'",
        "device": "'$devicename'",
        "filename": "'$zip_only'",
        "download": "'$download'",
        "timestamp": '$timestamp',
        "md5": "'$md5'",
        "size": '$size',
        "version": "'$version'",
        "buildtype": "'$buildtype'",
        "forum": "'$forum'",
        "gapps": "'$gapps'",
        "firmware": "'$firmware'",
        "modem": "'$modem'",
        "bootloader": "'$bootloader'",
        "recovery": "'$recovery'",
        "paypal": "'$paypal'",
        "telegram": "'$telegram'"
    }
  ]
}' >> $device.json
echo ""
cat $device.json
