### Content
* Symfony
* Centos 7
* Nginx
* Php56-fpm

### Check status
* http://server.name:port/config.php       => /source/web
* http://server.name:port/test.php       => /source/web
* http://server.name:port/app_dev.php      => /source/web

### Install
* Run container
```bash
$ docker run -d -P --name symfony images_name
```

* Volumes data
```bash
$ docker run -d -P --name symfony -v /var/www/html/symfony_resource:/source images_name
```

* Run command when container is running
```bash
$ docker exec -it images_name /bin/bash
```

* Check info
```bash
$ docker inspect images_name
```

* Timezone php config
``` date.timezone = UTC ```

* Structure folder
     -  | /(root)
     -  |...../source/
     -  |...../logs/
