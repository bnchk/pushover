#!/bin/bash
# NOTIFICATION SCRIPT FOR TRIGGERING PUSH MESSAGE ON LOGIN EVENTS
# Script is triggered by PAM event on ssh or console login
# To be notified also when session closes, you can watch for the "close_session" value.
if [[ "$PAM_TYPE" == "open_session" ]]; then
          # Is this console or ssh?  Is triggered from both
          if [ "$PAM_SERVICE" == "sshd" ]; then LoginType="SSH"; elif [ "$PAM_SERVICE" == "login" ]; then LoginType="CONSOLE"; else LoginType="MYSTERY"; fi

          #Construct message
          PO_MSG="$LoginType LOGIN\n Box: `uname -n`\n User:$PAM_USER\n From:$PAM_RHOST\n Service: $PAM_SERVICE\n TTY: $PAM_TTY\n Date: `date`"

          #Send notification
          curl -s --connect-timeout 5 \
                --form-string "token=aba2na98ie34vb26wfs3kzq7d9x318" \
                --form-string "user=uggkp1g8ns32u8uiz73hww6pbqu4fm" \
                --form-string "message=`echo -e $PO_MSG`" \
                https://api.pushover.net/1/messages.json > /dev/null 2>&1 || true
fi
exit 0
