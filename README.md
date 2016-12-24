### Content
* Symfony
* Centos 7
* Nginx
* Php71-fpm

### Available on docker hub
* https://hub.docker.com/r/devhoanggia

### Structure folder
* Source: /data/www

### Exec
* Add content to /etc/host
```
testsite.local dev.local
```
* Run
```
./cli docker build
./cli docker test
```

### Config
* Timezone php.ini config
``` date.timezone = UTC ```