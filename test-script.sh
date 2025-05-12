#!/bin/bash

# Переменные, которые будем использовать
PROC_NAME="test" 
LOG_FILE="/var/log/monitoring.log"
API_URL="https://test.com/monitoring/test/api"
PID_STATE_FILE="/var/tmp/test_state"
# ----------------------------------------
# ID процесса, используем утилиту pgrep
# для поиска процессов по имени, флагом -x
# сопоставляем по шаблону, флагом -o
# выбираем самый старый процесс
# ----------------------------------------
PID=$(pgrep -xo "$PROC_NAME")

# Если процесса нет, выходим
if ! [[ "$PID" ]]; then exit 0; fi

# ---------------------------------------
# Существует ли файл, если да, то получаем
# PID, который в нём записан, иначе ""
# --------------------------------------
if [[ -f "$PID_STATE_FILE" ]]; then 
        LAST_PID=$(cat "$PID_STATE_FILE")
else
        LAST_PID=""
fi

# Логируем перезапуск и перезаписываем последний PID
if [[ "$PID" != "$LAST_PID" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Процесс '$PROC_NAME' перезапущен c PID: $PID" >> "$LOG_FILE"
        echo "$PID" > "$PID_STATE_FILE"
fi

# Стучимся в API без вывода, 10 секунд на подключение
curl -s --connect-timeout 10 "$API_URL" > /dev/null
if [[ $? != 0 ]]; then echo "$(date '+%Y-%m-%d %H:%M:%S') Сервер мониторинга $API_URL не доступен" >> "$LOG_FILE"; fi