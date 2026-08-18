
#!/usr/bin/env bash

echo "$(date) after-resume" >> ~/.swayidle.log
# bluetoothctl power on
# nmcli radio wwan on
/run/privileged/bin/mbimcli -p -d /dev/wwan0mbim0 --quectel-set-radio-state=on
