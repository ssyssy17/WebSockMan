#!/bin/bash

source ./WebSockMan.ini     # 설정파일 로드

while(true)
do
    GET_PID

    _____DEBUG_____ ""
    _____DEBUG_____ "┌───────────────────────────────────────────────────────────"
    _____DEBUG_____ "│   .INI   [ INFO ]    "
    _____DEBUG_____ "├───────────────────────────────────────────────────────────"
    _____DEBUG_____ "│ SERVER_URL" "${SERVER_URL}"
    _____DEBUG_____ "│ SERVER_PORT" "${SERVER_PORT}"
    _____DEBUG_____ "│ SERVER_APP_PATH" "${SERVER_APP_PATH}"
    _____DEBUG_____ "│ SERVER_APP" "${SERVER_APP}"
    _____DEBUG_____ "│ SERVER_APP_CMD" "${SERVER_APP_CMD}"
    _____DEBUG_____ "│ DEBUG_FLAG" "${DEBUG_FLAG}"
    _____DEBUG_____ "│ TIMEOUT_SECOND" "${TIMEOUT_SECOND}"
    _____DEBUG_____ "│ CHK_INTERVAL" "${CHK_INTERVAL}"
    _____DEBUG_____ "│ WSM_DATE" "${WSM_DATE}"
    _____DEBUG_____ "│ WSM_LOG_PATH" "${WSM_LOG_PATH}"
    _____DEBUG_____ "│ WSM_LOG_FILE_NM" "${WSM_LOG_FILE_NM}"
    _____DEBUG_____ "└───────────────────────────────────────────────────────────"
    _____DEBUG_____ ""

    _____DEBUG_____ " `date "+%Y/%m/%d %H:%M:%S"`"
    _____DEBUG_____ "┌───────────────────────────────────────────────────────────"
    _____DEBUG_____ "│ PID" "${SERVER_PID}"

    #요청 시작시간
    start_time=`date "+%s"`

    #서버 요청
    res=`curl -s --max-time $TIMEOUT_SECOND "$SERVER_URL:$SERVER_PORT"/ws_chk`
    _____DEBUG_____ "│ RES" "${res}"

    #요청 종료시간
    end_time=`date "+%s"`

    interval=`echo "$end_time - $start_time" | bc`
    _____DEBUG_____ "│ INTERVAL" "${interval}"

    #타임아웃 제한시간 초과
    if [ $interval -ge $TIMEOUT_SECOND ]; then
        _____DEBUG_____ "│ ---------- TIMEOUT ----------"
        ELOG "TIMEOUT" "[ ${SERVER_PID} ]"
        SERVER_START
    #서버 DOWN
    elif [ "$res" == "" ]; then
        _____DEBUG_____ "│ ---------- SERVER DOWN ----------"
        ELOG "SERVER DOWN" "[ ${SERVER_PID} ]"
        SERVER_START
    fi

    sleep $CHK_INTERVAL

    _____DEBUG_____ "└───────────────────────────────────────────────────────────"
    _____DEBUG_____ ""

done
