FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive


# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody 
RUN usermod -g 100 nobody 
RUN usermod -d /home nobody 
RUN chown -R nobody:users /home

# Install Dependencies
RUN apt-get update -q && apt-get install -qy \
    mysql-client \ 
    cron \ 
    tzdata \ 
    pv \
    && rm -rf /var/lib/apt/lists/*

# Create docker folders
RUN mkdir /config 
RUN mkdir /backup

VOLUME /backup

# Add our crontab file
ADD crontab.txt /config/crontab.txt
ADD cronjob /config/cronjob

# Make cronjob executable
RUN chmod +x /config/cronjob

# Add firstrun.sh to execute during container startup, changes mysql host settings.
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD /etc/my_init.d/firstrun.sh && cron && tail -f /var/log/cron.log