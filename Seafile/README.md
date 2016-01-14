Seafile 4.4.6 for ReadyNAS OS 6.4.1
===================================

## 1. Description

This is the procedure to install Seafile v4.4.6 on ReadyNAS OS 6.4.1.
This won't work for Seafile v5. There is a specific problem that hasn't been solved yet ([See here](https://forum.seafile-server.org/t/importerror-cannot-import-name-caches/3540)).

This is based on the following work : [link here](http://www.rooot.net/en/geek-stuff/synology/40-seafile-on-armv7-based-synology-diskstation-nas.html) 

## 2. Requirements

### A. General

This is needed to compile Seafile but also to meet his requirements:

	sudo apt-get install libevent-dev libcurl4-openssl-dev libglib2.0-dev uuid-dev intltool libsqlite3-dev libmysqlclient-dev libarchive-dev libtool libjansson-dev valac libfuse-dev re2c flex cmake libssl-dev libjpeg8-dev python-dev sudo
	
Doing that, a warning will occurs when you want to use apt for example.
This is the error :

	insserv: warning: script 'leafp2p' missing LSB tags and overrides
	insserv: There is a loop between service logitechmediaserver and leafp2p if stopped
	insserv:  loop involving service leafp2p at depth 2
	insserv:  loop involving service logitechmediaserver at depth 1
	insserv: Stopping leafp2p depends on logitechmediaserver and therefore on system facility `$all' which can not be true!
	insserv: exiting now without changing boot order!
	update-rc.d: error: insserv rejected the script header

You have to modify the file */etc/init.d/leafp2p*
If you had the following, you will not have further problems ([forum post here](https://community.netgear.com/t5/Using-your-ReadyNAS/LSB-issue-on-leafp2p/td-p/929396)):

	### BEGIN INIT INFO
	# Provides:          leafp2p
	# Required-Start:    $network $remote_fs $syslog
	# Required-Stop:     $network $remote_fs $syslog
	# Default-Start:     2 3 4 5
	# Default-Stop:      0 1 6
	# Short-Description: P2P functionality for addons and applications
	### END INIT INFO



### B. Python

	sudo apt-get install python-simplejson python-chardet gunicorn python-imaging python-six sqlite3 python-dateutil python-pip

	sudo pip install django==1.5
	sudo pip install djblets==0.6
	sudo pip install django-compressor==1.4
	sudo pip install Pillow==2.6.1

### C. Manual Compilation

You need to compile some of the libraries that are not available for ReadyNAS OS.

 - libzdb
 
		wget http://www.tildeslash.com/libzdb/dist/libzdb-2.12.tar.gz
		tar xf libzdb-2.12.tar.gz
		cd libzdb-2.12
		./configure
		make
		sudo make install
		
 - libevhtp
 
		wget https://github.com/ellzey/libevhtp/archive/1.1.6.tar.gz
		tar xf 1.1.6.tar.gz
		cd libevhtp-1.1.6/
		cmake -DEVHTP_DISABLE_SSL=ON -DEVHTP_BUILD_SHARED=ON .
		make
		sudo make install

 - django-statici18n
	
		wget https://pypi.python.org/packages/source/d/django-statici18n/django-statici18n-1.1.3.tar.gz
		tar xf django-statici18n-1.1.3.tar.gz
		cd django-statici18n/
		python setup.py install

## 3. Installation

Follow the official procedure and don't forget the little fix in *controller/seafile-controller.c*. 
All the explanations can be found [here](http://www.rooot.net/en/geek-stuff/synology/40-seafile-on-armv7-based-synology-diskstation-nas.html).

It is possible that an error occurs during the installation because he doesn't found either *libsearpc* or *libzdb*.
To solve that you have to create a symbolic link :

	sudo ln -s /usr/local/lib/libsearpc.so.1 /usr/lib/libsearpc.so.1
	sudo ln -s /usr/local/lib/libzdb.so.10 /usr/lib/libzdb.so.10

## 4. Automatic start-up

I wrote two little scripts to allow the automatic startup of Seafile.
The first one, *seafile_launch.sh*, you have to copy it in your seafile directory. 
The second one, *seafile.service*, you have to copy it to */etc/systemd/system*

**Note**: You must adapt the path to seafile to your installation in both of the files.

Make sure the rights are corrects ! These scripts must be executable !

Then you have to execute the command : 

	sudo systemctl enable seafile.service
