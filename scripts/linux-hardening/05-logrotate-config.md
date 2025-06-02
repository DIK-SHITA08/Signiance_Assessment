# Logrotate Configuration

Ubuntu comes with logrotate installed. To customize:

- Edit or add files in `/etc/logrotate.d/`
- Example for Nginx or custom apps:

/var/log/myapp/*.log {
daily
missingok
rotate 14
compress
delaycompress
notifempty
create 0640 ubuntu adm
sharedscripts
postrotate
systemctl reload myapp
endscript }