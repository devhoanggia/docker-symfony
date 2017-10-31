# Build image nginx with Docker

### Content
* Centos 7
* Nginx
* PHP-FPM (7.1)
* Support project Laravel, Symfony

### Available on docker hub
* http://quay.io/devhoanggia

### Config
* Timezone php.ini config
``` date.timezone = UTC ```
* Source: /data/www

### Install
* Add this line below  to /etc/host
```
laravel.local symfony.local
```
* Run this command to build and run container
```
$ docker-compose -f docker-compose.yml up --build -d
```

### SSH Container
```
$ docker exec -it container_name bash
```
