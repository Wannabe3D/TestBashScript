# TestBashScript
This test Bash script for monitoring test process every minute

Systemd Unit service for script:
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
Systemd Timer for systemd Unit:
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
Start commands for running and debugging:
`systemctl daemon-reload`
`systemctl enable test-monitoring.service` 
`systemctl start test-monitoring.service`
`systemctl status test-monitoring.service`
`systemctl enable test-monitoring.timer`
`systemctl start test-monitoring.timer`
