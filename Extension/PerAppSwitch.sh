# Init
if  [ -d "/sdcard/Android/ct/DynamicList.txt" ];then
    touch "/sdcard/Android/ct/DynamicList.txt"
fi

while [ true ]; do
    CurrentApp=${dumpsys window | grep mCurrentFoucs}
    CurrentAppName=${echo "$CurrentApp" | cut -d ' ' -f 3 | cut -d '/' -f 1}
    if grep -q "${CurrentAppName}" /sdcard/Android/ct/DynamicList.txt
        CaseResult=${grep "${CurrentAppName}" /sdcard/Android/ct/DynamicList.txt}
        ScheduleMode=${echo "$CaseResult" | awk -F';' '{print $2}' }
        echo "$ScheduleMode" > /sdcard/Android/ct/cur_mode.txt
        ${SCRIPT_PATH}/CuDaemon -R "${SCRIPT_PATH}/config.json" "/sdcard/Android/ct/cur_mode.txt" "/sdcard/Android/ct/scheduler.log"
        sleep 60s
    else 
        sleep 30s
done

