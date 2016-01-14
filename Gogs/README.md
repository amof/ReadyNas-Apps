Gogs for ReadyNAS OS 6.4.1
===================================

See the installation instruction here :

http://blog.meinside.pe.kr/Gogs-on-Raspberry-Pi/

## Automatic start-up

Copy *gogs.service* into */etc/systemd/system*

Make sure the rights are corrects ! These scripts must be executable !
This is very important !

You have also to create a directory in */home/git/gogs/logs* for the logs.

Then you have to execute the command : 

	sudo systemctl enable seafile.service