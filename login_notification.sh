#!/bin/bash
# NOTIFICATION SCRIPT FOR TRIGGERING PUSH MESSAGE ON LOGIN EVENTS
# We want to trigger the script only when the SSH session starts.
# To be notified also when session closes, you can watch for the "close_session" value.
if [[ "$PAM_TYPE" == "open_session" ]]; then
      #Construct message
      PO_MSG="SSH LOGIN\n User:$PAM_USER\n Host:$PAM_RHOST\n Service: $PAM_SERVICE\n TTY: $PAM_TTY\n Box: `uname -n`\n Date: `date`"
	  
	  #Send notification
      curl -s \
        --form-string "token=YOUR-APP-API-TOKEN-HERE" \
        --form-string "user=YOUR-USER_API-TOKEN-HERE" \
        --form-string "message=`echo -e $PO_MSG`" \
        https://api.pushover.net/1/messages.json > /dev/null || true
fi
exit 0
