### Content
* Symfony
* Centos 7
* Nginx
* Php56-fpm

### Available on docker hub
* https://hub.docker.com/r/devhoanggia/docker-symfony/

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
$ docker run -d -P --name symfony -v /symfony_resource:/source images_name
```

* Run command when container is running
```bash
$ docker exec -it images_name /bin/bash
```

* Check info
```bash
$ docker inspect images_name
```

* Timezone php.ini config
``` date.timezone = UTC ```

* Use composer
```
$sudo vi /usr/local/bin/composer
```
- Add content
```
#!/bin/sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
echo "Current working directory: '"$(pwd)"'"
docker run --rm -v $(pwd):/app -v ~/.ssh:/root/.ssh composer/composer $@
```
- Chmod this file
```
$ sudo chmod +x /usr/local/bin/composer
```

- Check version
```
$ composer --version
```

- Reference : https://hub.docker.com/r/composer/composer/