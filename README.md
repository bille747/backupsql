# Description
BackupSQL is a docker container for backing-up your MySQL Server automatically on a cron schedule.

It automatically connects to the MySQL server, gets a list of the user databases and compresses it using Pigz (Multithreaded GZIP).

**Note**: This container will **not** backup the following databases:
- mysql 
- information_schema
- performance_schema
- sys

# QuickStart
In order to start using this container, simply run the following command:
```Docker
docker run -d --name "BackupSQL" -e "TZ=America/New_York" -e "bkpMinute=0" -e "bkpHour=3" -e "bkpDayOfMonth=*" -e "bkpMonth=*" -e "bkpDayOfWeek=*" -e "MySQLIP=192.168.2.2" -e "SQL_userid=mysqluser" -e "SQL_pwd=mysqlpass" -e "BackupCopies=8" -v "/path/to/backup/:/backup" bille747/backupsql
```

# Container Parameters
This Docker Container uses the following parameters.
| Parameter | Function |
|:---------:|----------|
|`--name "BackupSQL"`| The name of the container. |
|`-e "TZ=America/New_York"`| The timezone of the container. See [Wikipedia Article](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).|
|`-e "bkpMinute=0"`| The exact minute at which the backup should run (from 0 - 59).|
|`-e "bkpHour=3"`| The exact hour of the day at which the backup should run (from 0 - 23).|
|`-e "bkpDayOfMonth=*"`| The exact day of the month at which the backup should be run (from 1 - 31). <br> **Note**: Use a `*` to specify all days of the month.|
|`-e "bkpMonth=*"`| The exact month at which the backup should beb run (from 1 - 12). <br> **Note**: Use a `*` to specify all months of the year.|
|`-e "bkpDayOfWeek=*"`| The exact day of the week at which the backup should be run (from 0 - 6). <br> **Note**: Use a `*` to specify all days of the week.|
|`-e "MySQLIP=192.168.2.2"`| The IP Address (Or hostname) of the MySQL Server you wish to backup.|
|`-e "SQL_userid=mysqluser"`| The username that the container will use to login to MySQL. <br> **Note**: It is best to avoid using root as the backup user. Instead, a seperate backup user should be created with the following global privileges: "SHOW DATABASES", "SELECT", "EVENT", "LOCK TABLE"|
|`-e "SQL_pwd=mysqlpass"`| The password for the MySQL user.|
|`-e "BackupCopies=8"`| How many days after a backup was done should the container automatically delete.|
