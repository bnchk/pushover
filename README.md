**Ubuntu SSH Logon Push notifications via Pushover app**
Whenever there is an ssh login to the machine, send a custom push message notification to another device.

**Step1:  Create account at pushover.net**
  $5 per device class perpetual licence (or can use trial period to test)
  This will give you a user api key
  Am not affiliated in any way, they simply looked good.  There are other choices.

**Step2:  Create application at pushover.net**
  You can get a secondary apikeys for free for grouping messages.
  This will allow grouping of notifications by application (eg all ssh logons, or just ssh logons for certain machines)
  It is used in conjunction with the user api key

**Step3:  Create notification script**
  The notification script is what is run when ssh logon is detected.
  You can place it where suits for you, and set to be only accessible by root user.
  For example if placing script here: `/opt/my_scripts/login_notification.sh`
  set permissions with:
  `sudo chown root:root /opt/my_scripts/login_notification.sh`
  `sudo chmod 700 /opt/my_scripts/login_notification.sh`

**Step4:  Create PAM trigger to run notification script**
  Add the following line to the end of `/etc/pam.d/sshd`
  eg:
  `sudo vi /etc/pam.d/sshd`
  and add at end the following:
  `# SSH login Push message notification
  session optional pam_exec.so /opt/my_scripts/login_notification.sh`
