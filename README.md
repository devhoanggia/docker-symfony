### Content
* Symfony
* Centos 7
* Nginx
* Php71-fpm

### Available on docker hub
* https://hub.docker.com/r/devhoanggia/docker-symfony

### Structure folder
* Web source: /data/www

### Setup
* Build image
```
$ docker build --no-cache -t="docker-symfony" .
$ docker build -t=“docker-symfony" .
```

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

* Timezone php.ini config
``` date.timezone = UTC ```