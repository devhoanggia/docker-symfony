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
* Copy all file in `Deploy` folder to your project
* Run this command
```
$ docker-compose -f docker-compose.yml up -d
```