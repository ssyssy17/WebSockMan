#!/bin/bash

source ./WebSockMan.ini     # 설정파일 로드

while(true)
do
    GET_PID

    _____DEBUG_____ "`date "+%Y/%m/%d %H:%M:%S"`"
    _____DEBUG_____ "============================================================"
    _____DEBUG_____ "[PID] ${SERVER_PID}"

    #요청 시작시간
    start_time=`date "+%s"`

    #서버 요청
    res=`curl -s --max-time $TIMEOUT_SECOND "$SERVER_URL:$SERVER_PORT"`
    _____DEBUG_____ "[RES] ${res}"

    #요청 종료시간
    end_time=`date "+%s"`

    interval=`echo "$end_time - $start_time" | bc`
    _____DEBUG_____ "[INTERVAL] ${interval}"

    #타임아웃 제한시간 초과
    if [ $interval -ge $TIMEOUT_SECOND ]; then
        _____DEBUG_____ "---------- TIMEOUT ----------"
        ELOG "TIMEOUT!!"
        SERVER_START
    #서버 DOWN
    elif [ "$res" == "" ]; then
        _____DEBUG_____ "---------- SERVER DOWN ----------"
        ELOG "SERVER DOWN!!"
        SERVER_START
    fi

    sleep $CHK_INTERVAL

    _____DEBUG_____ "============================================================"
    _____DEBUG_____ ""

done
