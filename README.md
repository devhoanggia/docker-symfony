# Docker build image

### Content
* Centos 7
* Nginx
* PHP-FPM (7.1)
* Support project Laravel, Symfony

### Available on quay.io
* docker pull quay.io/devhoanggia/nginx

### Config
* Timezone php.ini config
``` date.timezone = UTC ```

### Install
* Add this line below  to /etc/host
```
laravel.local symfony.local
```

### Build image
```
./cli build
```

### Run with out docker-compose
    docker run -d -p 80:80 --name my-nginx -v "$PWD":/www/public quay.io/devhoanggia/nginx