Gotty Docker
==================================================

Docker image with browser based linux terminal.

[View Demo][1] (may take a minute to start the container).


Usage
--------------------------------------------------

    $ docker run -p3000:3000 dannyben/gotty


[1]: https://gotty.herokuapp.com
# docker-gotty docker in docker

Usage with traefik
### start up traefik container, ex:
### https://github.com/eshnil2000/traefik-docker-browser-letsencrypt/blob/master/localhost/docker-compose.yml
-------
```
docker network create -d overlay --attachable traefik_default
docker build -t docker-gotty .
docker stack deploy -c docker-compose.yml gotty
```
