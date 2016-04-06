### Content
* Symfony
* Nginx
* Php5-fpm

### Check status
* http://server.name:port/check_status.php => /var/www/html
* http://server.name:port/test.php => /var/www/html/source
* http://server.name:port/app_dev.php  => /var/www/html/source

### Install
* Run container
```
$ docker run -d -P --name test images_name
```

* Volumes data
```
$ docker run -d -P --name test -v /var/www/html/myfolder:/var/www/html images_name
```

* Run command when container is running
```
$ docker exec -it images_name /bin/bash
```

* Check info
```
$ docker inspect images_name
```