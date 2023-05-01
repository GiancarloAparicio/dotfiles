

initial-adb(){
    local phone=$( adb devices | awk '{print $1}' | sed -n 2p)
    sleep 0.5
    (&>/dev/null  adb connect $phone:5555 &)

    echo $phone
}

adb-shell(){
    initial-adb

}

adb-copy(){
    local device=$(initial-adb)
    if [ "$@" ]; then
        directory=$1
    else
        read "directory? Ingrese el archivo local a copiar (archivo/directorio):  "
    fi

    remote=$(basename $directory)
    remote="/storage/E09C-0DE6/Linux/$remote"

    echo "remoto: $remote"
    echo "local: $directory"

    adb -s $device shell mkdir -p "/storage/E09C-0DE6/Linux/"

    # if $directory is a file
    if [ -f $directory ]; then
        adb -s $device push $directory "/storage/E09C-0DE6/Linux/"
    else
        adb -s $device shell mkdir -p $remote
        adb -s $device push $directory/* $remote
    fi
    adb -s $device  shell ls -al $remote
}

adb-install(){
    local device=$(initial-adb)
    for pack in $(ls | grep -E '\.apk$'); do
        echo "Install: $pack"
        adb -s $device  install -r  $pack
    done
}

adb-text(){
    local device=$(initial-adb)
    temp="text.sh"
    echo "input text \"$(xclip -selection c -o | rev | cut -c1- | rev | tr -d '"' )\" " > $temp

    adb -s $device push $temp /data/local/tmp/
    adb -s $device shell chmod +x /data/local/tmp/$temp 
    adb -s $device shell sh /data/local/tmp/$temp 
    /bin/rm $temp
}

adb-forward(){
    local device=$(initial-adb)
    echo "Mapea un puerto de la PC a tu celular"
    read "port2?  Eliga el puerto de Android:  "
    echo $port2

    read "port1?  Eliga el puerto de la PC:  "
    echo $port1

    adb -s $device forward tcp:$port1 tcp:$port2
}

adb-reverse(){
    local device=$(initial-adb)

    echo "Mapea un puerto del celular a tu PC"
    read "port2?  Eliga el puerto de Android:  "
    echo $port2

    read "port1?  Eliga el puerto de la PC:  "
    echo $port1

    adb -s $device forward tcp:$port2 tcp:$port1
}



termux-shell(){
    local device=$(initial-adb)

    # if device is direction IP address then use adb connect
    if ! [[ $device =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        adb connect $device:5555
        host=$device
    else
        host=localhost
    fi

    # if $device exist then echo "connect" else echo "disconnect"
    if [ $device ]; then
        nc -z -v  $host 8022 2>/dev/null || (
             (&>/dev/null  killall gnirehtet &)

             (&>/dev/null adb shell am force-stop com.genymobile.gnirehtet &)
             sleep 1
             (&>/dev/null adb shell monkey -p com.termux -c android.intent.category.LAUNCHER 1 &)
             sleep 1

             adb forward tcp:8022 tcp:8022 2>/dev/null

             if ! [[ $device == *"5555"* ]]; then
                 sleep 1
                 if [ -x "$(command -v gnirehtet)" ]; then
                     (&>/dev/null gnirehtet run &)
                 fi
            fi

        )

        ssh -p 8022 root@$host "sh -c 'cd ~/brain; nohup  bash .scripts/sync.sh > /dev/null 2>&1 &'"


        nc -z -v $host 8022 2>/dev/null && (
            ssh -p 8022 root@$host
        ) || (

            if ! [ -z "${device}" ]; then
                (&>/dev/null adb -s $device shell am force-stop com.genymobile.gnirehtet &)
                (&>/dev/null adb -s $device forward --remove tcp:8022 &)
            fi

            (&>/dev/null  killall gnirehtet &)
            (&>/dev/null  killall adb &)
            (&>/dev/null adb disconnect &)
        )

    else
        ssh zte
    fi

    }

alias ts="termux-shell"

adb-remove-apps(){

    local device=$(initial-adb)
    list=$( adb shell  pm list packages -e | _fzf-show --no-preview |  cut -d : -f 2)

    while IFS= read -r app; do
        adb -s $device  shell pm uninstall -k --user 0 $app
    done <<<"$list"

}

adb-screenrecord(){

    local device=$(initial-adb)
    read "video? Ingrese un nombre para el video  "
    video=${video:-screen-record}
    scrcpy --record "./$video.mp4"
}

# APK
alias apk-install="adb-install"
alias apk-remove="adb-remove-apps"


