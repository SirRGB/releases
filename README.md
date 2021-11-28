# Build scripts

**DISCLAIMER**: This is only for Debian-based distributions. WSL is **NOT** supported.

## Prerequisites

1. (Optional) Make a Telegram Bot ([@BotFather](https://t.me/BotFather)).

2. Fork this repository.

3. Make a GitHub token with proper permissions for uploading releases to your repositories.

## How to use this repo (non-Jenkins)

1. Clone your fork of this repository.

2. Make your changes in `config.sh` (more information about the flags below). Make sure you commit and push your changes to your fork.

3. Export GITHUB_TOKEN to your GitHub token (make sure it has permissions to upload releases to your repos).

4. Optionally export TELEGRAM_CHAT and TELEGRAM_TOKEN to your respective values:

* `TELEGRAM_CHAT` - the ID of the channel/group chat you want the Bot to post your messages to.

* `TELEGRAM_TOKEN` - the token of your Telegram Bot.

5. If you haven't ever built Android on your PC, open a terminal in the directory you cloned this repository and run `setup.sh`.

6. Then run `init.sh` from the same folder.

OR

5. If you've already built Android on your PC, run `init.sh`.

## How to use this repo (Jenkins)

1. Clone your fork of this repository.

2. Make your changes in `config.sh` (more information about the flags below). Make sure you commit and push your changes to your fork.

3. Open the Jenkins web console.

4. Make a new job with the "Freeflow" type. Do **NOT** put spaces in the name of the job.

5. Add a build step for bash.

6. Copy the contents of `jenkins.sh` to it.

7. Change the values of GITHUB_TOKEN and optionally TELEGRAM_CHAT, TELEGRAM_TOKEN to your respective values:

* `GITHUB_TOKEN` - your GitHub token (make sure it has permissions to upload releases to your repos).

* `TELEGRAM_CHAT` - the ID of the channel/group chat you want the Bot to post your messages to.

* `TELEGRAM_TOKEN` - the token of your Telegram Bot.

8. Edit the `git clone` command for your fork.

## Configuration flags

`RELEASES_DIR` - where you cloned the repository, needed for telegram announcement images

```
You'll need to put your own images into assets folder in the repo. Check "Announcement images" section for more info.
```

`GITHUB_USER` - your GitHub username

`GITHUB_EMAIL` - your GitHub email

`device` - your device codename (e.g. `blueline` for Pixel 3)

`ROM` - name of your ROM (e.g. `AOSP`)

`ROM_DIR` - directory where your ROM source will reside (e.g. `/var/lib/jenkins/AOSP`)

`ROM_VERSION` - version of your ROM (e.g. `9.0 Pie`)

`official` - `true` if you're building an official build, `false` if you're building an unofficial build

`local_manifest_url` - your local manifest URL (e.g. `https://example.link/local_manifest.xml`)

```
Note that you'll need to comment this out or erase its content in order to use old school variables.
```

`manifest_url` - your ROM's manifest repo URL (e.g. `https://android.googlesource.com/platform/manifest`)

`referencedir` - the directory that will be taken as reference while syncing

```
Keep in mind, not all ROMs use the same remote under same name. For example, if the target ROM is using laos but reference is using lineage as remote name, all repos from that remote will be kept back.
```

`rom_vendor_name` - your ROM's custom vendor name (e.g. `lineage`)

`branch` - branch of the manifest to sync (e.g. `lineage-16.0`)

`bacon` - the package to build (default: `bacon`)

`buildtype` - the build type to build (e.g. `userdebug`). If you don't specify a build type, it defaults to userdebug.

`clean` - `installclean` if you want to clear system/ and vendor/ directories, `clean` if you want a clean build, `false` if you want a dirty build

`generate_incremental` - `true` if you want the script to generate and upload an incremental update zip, `false` if you don't want the script to generate and upload an incremental update zip

`upload_recovery` - `true` if you want the script to upload the built recovery image, `false` if you don't want the script to upload the recovery image

`ccache` - `true` if you want to build with ccache, `false` if you don't

`ccache_size` - how many gigabytes of space to dedicate to ccache (e.g. `50`).

`jenkins` - `true` - you use Jenkins; `false` - you don't use Jenkins

`release_repo` - your GitHub username + name of the repo to upload the releases (e.g. `JarlPenguin/releases`)

`timezone` - your timezone (default: `UTC`)

`devicetree` - your device tree / `devicepath` - destination path for it / `devicebranch` - branch of it

`devicetreecommon` - your common device tree (and so on)

`kerneltree` - your kernel tree (and so on)

`vendortree` - your vendor tree (and so on)

```
Until a proper implementation is done, you have to omit the git commands in sync.sh that have the variables you commented out in config.
```

## Announcement images

In November 27, 2021, [I, as Bedirhan, have introduced image additions in announcement messages.](https://github.com/windowz414/releases/commit/4a7733f71c12136d2f5e9d5f4456fdc02363c8b2).

These images are placed inside assets folder and messages they're used are as follows;

`sync1.png` - "Sync started for ROM"

`sync2.png` - "Sync failed in x minute(s) and y second(s)"

`sync3.png` - "Sync completed successfully in x minute(s) and y second(s)"

`build1.png` - "Build started for device"

`build2.png` - "Build failed in x minute(s) and y second(s)"

`build3.png` - "Build completed successfully in x minute(s) and y second(s)"
