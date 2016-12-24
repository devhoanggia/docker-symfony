### Content
* Symfony
* Centos 7
* Nginx
* Php71-fpm

### Available on docker hub
* https://hub.docker.com/r/devhoanggia

### Config
* Timezone php.ini config
``` date.timezone = UTC ```
* Source: /data/www

### Install
* Add this line below  to /etc/host
```
test.local dev.local
```
* Run this command
```
./cli docker build
./cli docker test
```
* http://test.local:9999
* http://dev.local:9999