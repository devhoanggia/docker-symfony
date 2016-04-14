### Content
* Symfony
* Centos 7
* Nginx
* Php56-fpm

### Check status
* http://server.name:port/check_status.php => /var/www/html
* http://server.name:port/test.php => /var/www/html/source
* http://server.name:port/app_dev.php  => /var/www/html/source

### Install
* Run container
```
$ docker run -d -P --name symfony images_name
```

* Volumes data
```
$ docker run -d -P --name symfony -v /var/www/html/symfony_resoure:/var/www/html/source images_name
```

* Run command when container is running
```
$ docker exec -it images_name /bin/bash
```

* Check info
```
$ docker inspect images_name
```

* Structure folder
... /var/www/html/
...        |.....check_server.php
...        |.....source/
...        |.....logs/
