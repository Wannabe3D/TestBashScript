# TestBashScript
This test Bash script for monitoring test process every minute

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
