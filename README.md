# TestBashScript
Это тестовое задание, написать скрипт, который будет мониторить тестовый процесс каждую минуту

Systemd Unit сервис для скрипта:
`sudo nano /etc/systemd/system/test-monitoring.service`
```bash
[Unit]
Description=Monitoring Process "test"
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/test-script.sh

[Install]
WantedBy=multi-user.target
```
Systemd Timer для systemd Unit:
`sudo nano /etc/systemd/system/test-monitoring.timer`
```bash
[Unit]
Description=Run Monitoring Process "test" every minute

[Timer]
OnBootSec=1m
OnCalendar=*:0/1  
Unit=test-monitoring.service

[Install]
WantedBy=timers.target
```
Для запуска юнитов, таймеров и отладки используем следующие команды:
`systemctl daemon-reload`
`systemctl enable test-monitoring.service` 
`systemctl start test-monitoring.service`
`systemctl status test-monitoring.service`
`systemctl enable test-monitoring.timer`
`systemctl start test-monitoring.timer`
