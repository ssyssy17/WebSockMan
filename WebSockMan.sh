#!/bin/bash

source ./WebSockMan.ini     # 설정파일 로드

while(true)
do

_____DEBUG_____ LOOP START

    #요청 시작시간
    start_time=`date "+%s"`
    #서버 요청
    RES=`curl -s --max-time $TIMEOUT_SECOND "$SERVER_URL:$SERVER_PORT"`
    #요청 종료시간
    end_time=`date "+%s"`

    interval=`echo "$end_time - $start_time" | bc`

_____DEBUG_____ $interval

    #타임아웃 제한시간 초과
    if [ $interval -ge $TIMEOUT_SECOND ]
    then
_____DEBUG_____ TIMEOUT
        ELOG "TIMEOUT!!"
        SERVER_START
    fi
    #서버 DOWN
    if [ "$RES" == "" ]
    then
_____DEBUG_____ SERVER DOWN
        ELOG "SERVER DOWN!!"
        SERVER_START
    fi

_____DEBUG_____ $CHK_INTERVAL

    sleep $CHK_INTERVAL

done
