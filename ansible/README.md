# Comet Backup Synology Install Ansible

The Comet app is not allowed to run as root on a Synology NAS. If you want to backup the ** Active Backup for Business ** data, you need root access or you will not get the important config files that are needed for restore.

Comet Backup installs into the /opt folder. My understanding is that Synology will erase this folder during major updates. So it will need to be reinstall again.

# Comet Admin
You will need to enable public downloads unless you want to edit the playbook.
Setting --> Roles --> Software Builds

# Edit Playbooks
Be sure to edit the playbooks with your domain or Comet server name. Also the file name/path of your custom branding.

# After Install
The agent is installed in Lobby mode.
Go to your Comet admin dashboard and click on devices.
You will the device listed as Unregistered. All you need to do is assign it to a user.