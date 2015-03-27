# nerdzeu/nginx-php

This repo is part of the docker enviroment for nerdz (`nerdzeu/docker`).

It contains the nginx configuration and expose the ports 80 and 443.

This container contains a nginx version with the perl module enabled.

The `conf` directory contains samples of nginx configuration files. It should be mounted to the container `/etc/nginx` folder.
The `conf/certs` contains a self signed certificate, used for tests.

# Usage

Use it as part of nerdzeu/docker.

If you want to pull and run the image you can do it in the classical docker way:

```sh
docker pull nerdzeu/docker
docker run nerdzeu/docker
```

If you want to build the image:

```sh
docker build -t <name> .
```
