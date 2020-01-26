#!/bin/bash
echo "[$(date +%Y-%m-%d_%T)] - Container Started, running startup script." >> /var/log/cron.log
#Edit cronjob file
sed -i "s/MySQLIP/${MySQLIP}/" /config/cronjob
sed -i "s/SQL_userid/${SQL_userid}/" /config/cronjob
sed -i "s/SQL_pwd/${SQL_pwd}/" /config/cronjob
sed -i "s/TOKEN/${TOKEN}/" /config/cronjob
sed -i "s/BACKUPCOPIES/${BackupCopies}/" /config/cronjob

echo "[$(date +%Y-%m-%d_%T)] - Updated Cronjob script!" >> /var/log/cron.log

#Edit crontab.txt file
sed -i "s/MINUTE/${bkpMinute}/" /config/crontab.txt
sed -i "s/HOUR/${bkpHour}/" /config/crontab.txt
sed -i "s/DAYM/${bkpDayOfMonth}/" /config/crontab.txt
sed -i "s/MONTH/${bkpMonth}/" /config/crontab.txt
sed -i "s/DAYW/${bkpDayOfWeek}/" /config/crontab.txt

echo "[$(date +%Y-%m-%d_%T)] - Updated crontab!" >> /var/log/cron.log

export TERM=dumb

crontab /config/crontab.txt



