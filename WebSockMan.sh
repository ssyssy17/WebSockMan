#!/bin/bash

source ./WebSockMan.ini     # 설정파일 로드

while(true)
do

_____DEBUG_____ "LOOP START"
_____DEBUG_____ "SERVER_URL : "${SERVER_URL}
_____DEBUG_____ "SERVER_PORT : "${SERVER_PORT}
_____DEBUG_____ "TIMEOUT_SECOND : "${TIMEOUT_SECOND}
_____DEBUG_____ "CHK_INTERVAL : "${CHK_INTERVAL}

    #요청 시작시간
    start_time=`date "+%s"`
    #서버 요청
    res=`curl -s --max-time $TIMEOUT_SECOND "$SERVER_URL:$SERVER_PORT"`

_____DEBUG_____ "res : "${res}

    #요청 종료시간
    end_time=`date "+%s"`

    interval=`echo "$end_time - $start_time" | bc`

_____DEBUG_____ "interval : "${interval}

    #타임아웃 제한시간 초과
    if [ $interval -ge $TIMEOUT_SECOND ]
    then

_____DEBUG_____ "TIMEOUT"

        ELOG "TIMEOUT!!"
        SERVER_START
    fi
    #서버 DOWN
    if [ "$res" == "" ]
    then

_____DEBUG_____ "SERVER DOWN"

        ELOG "SERVER DOWN!!"
        SERVER_START
    fi

    sleep $CHK_INTERVAL

_____DEBUG_____ "LOOP END"

done
