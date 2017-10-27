#!/bin/bash

source ./WebSockMan.ini     # 설정파일 로드

while(true)
do

    #요청 시작시간
    start_time=`date "+%s"`
    #서버 요청
    RES=`curl -s --max-time $TIMEOUT_SECOND "$SERVER_URL:$SERVER_PORT"`
    #요청 종료시간
    end_time=`date "+%s"`

    interval=`echo "$end_time - $start_time" | bc`
    #타임아웃 제한시간 초과
    if [ $interval -ge $TIMEOUT_SECOND ]
    then
        ELOG "TIMEOUT!!"
        SERVER_START
    fi
    #서버 DOWN
    if [ "$RES" == "" ]
    then
        ELOG "SERVER DOWN!!"
        SERVER_START
    fi

    sleep $CHK_INTERVAL

done
