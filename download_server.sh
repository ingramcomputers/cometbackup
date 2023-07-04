# https://docs.cometbackup.com/latest/api/other-apis/#latestversion
# This is a bash script to download the latest version of Comet Backup Server
# Change the version to the version you need. See the link above for the option.

username="youremail@address.com"
password="Y0urP@ssword"
version="latest-quarterly"

wget --method POST --body-data "email=$username&password=$password&platform=download_linux_deb&version_key=$version" --content-disposition https://account.cometbackup.com/api/v1/downloads/get

