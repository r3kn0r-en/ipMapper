#!/bin/bash
now=$(date +%s%3N)
w="0"
x="0"
y="0"
count=0
max=255
END=255
echo "###BEGINNING OF FILE###" >> "output/$1_ip.list"
for y in $(seq 0 $END)
do
    for x in $(seq 0 $END)
    do
        for w in $(seq 0 $END)
        do
            ip=$1"."$y"."$x"."$w
            string=$(geoiplookup -l $ip)
            if [[ ${string:23:2} == "RU" ]]
            then
                echo $ip >> "output/$1_ip.list"
            fi
            let "count=count+1"
            if (( $count % 10000 == 0 ))
            then
            echo "-------------------------------"
            let msRunning=$(date +%s%3N)-$now
            secondsRunning=`bc <<< "scale=0; $msRunning/1000"`
            minutesRunning=`bc <<< "scale=1; $secondsRunning/60"`
            hoursRunning=`bc <<< "scale=2; $minutesRunning/60"`
            milliSecPerIp=`bc <<< "scale=20; $msRunning/$count"`
            remainingIps=`bc <<< "scale=0; 16581375-$count"`
            remainingSecs=`bc <<< "scale=0; ($milliSecPerIp*$remainingIps)/1000"`
            remainingMins=`bc <<< "scale=0; $remainingSecs/60"`
            remainingHours=`bc <<< "scale=2; $remainingMins/60"`
            remainingDays=`bc <<< "scale=5; $remainingHours/24"`
            percentDone=`bc <<< "scale=5; (($count/16581375)*100)"`
            echo "Mapping $1.X.X.X"
            echo "running since"
            echo "$hoursRunning hours or:"
            echo "$minutesRunning minutes or:"
            echo "$secondsRunning seconds"
            echo ""
            echo "percent done:"
            echo "$percentDone %"
            echo ""
            echo "IP's scanned:"
            echo "$count"
            echo ""
            echo "Latest IP at this point:"
            echo "$ip"
            echo ""
            echo "Remaining IP's:"
            echo "$remainingIps"
            echo ""
            echo "Latest IP mapped:"
            tail -1 "output/$1_ip.list"
            echo ""
            echo "estimated time left:"
            echo "$remainingDays days or:"
            echo "$remainingHours hours or:"
            echo "$remainingMins minutes or:"
            echo "$remainingSecs seconds"
            echo "-------------------------------"
            fi
        done
    done
done
echo "###END OF FILE###" >> "output/$1_ip.list"
