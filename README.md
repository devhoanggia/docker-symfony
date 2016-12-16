### Content
* Symfony
* Centos 7
* Nginx
* Php71-fpm

### Available on docker hub
* https://hub.docker.com/r/devhoanggia/docker-symfony

### Structure folder
* Web source: /data/www

### Exec
* Add content to /etc/host
```
testsite.local dev.local
```
* Run
```
./cmd docker start
./cmd init
```

### Config
* Timezone php.ini config
``` date.timezone = UTC ```