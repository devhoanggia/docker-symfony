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

* Timezone php.ini config
``` date.timezone = UTC ```