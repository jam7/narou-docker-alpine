# narou-docker-alpine
A narou.rb in docker using alpine / narou.rbをalpine linuxで実行するためのdocker環境

## Prerequisite

Need to install docker.

## Install

In order to use this, installation is not really needed.  There is docker image in public.

```
$ docker pull jam7/narou-alpine
```

## Build

In order to build image by yourself, perform `make`

```
$ make
```

## Usage

It is easy to use through [narou-docker-script](https://github.com/jam7/narou-docker-script).

## Where is data directory

All data are stored in `/opt/narou`.  So use `docker run -v $HOME/.narou:/opt/narou ...` command to use your `$HOME/.narou` as data directory.

## Run as web service

Use `docker run -p IP-ADDRESS:8000:8000 narou web -p 8000 -n`.

## License

@ 2016-2017 Kazushi (Jam) Marukawa, All rights reserved.

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt)

## Related projects

narou.rb is in https://github.com/whiteleaf7/narou.  
narou-docker is in https://github.com/migimigi/narou-docker.


