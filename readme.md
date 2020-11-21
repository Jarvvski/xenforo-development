# Xenforo Local Development

A template for developing addons for xenforo locally using docker containers to replicate a server experience using PHP-FPM, Nginx & MariaDB. All ports are exposed for easy access when querying the DB locally, or using xdebug in your IDE.

## Requirements

- docker-ce installed with respective command line
- docker-compose cli installed
- a copy of xenforo downloaded from the accounts panel

## Development env setup

1. Download a copy of xenforo 2 from your account panel, place into this directory and rename as `xenforo.zip`

2. Run `./install-from-zip.sh` to unpack the xenforo source

3. Run `docker-compose up -d` to start the containers

4. Run `docker exec xenforo php cmd.php xf:install --user=admin --password=admin --clear` to run the database migrations

5. Rename `src/addons/Acme/My-Addon/` to the relevant org name and addon name in both the file structure, `config.php` and the `.gitignore` file

6. Run `docker exec -it xenforo php cmd.php xf-addon:create` to create your addon

> Note: you can run step 2 again if you need to restore any default xenforo files to default

### PHPStorm Xdebug setup

Because FPM is running on it's default port of 9000 and exposed on your host, you will need to change a few defaults with PHPstorm to get things working. I recommend the [this youtube video](https://www.youtube.com/watch?v=J77iuOpnUm4) as a guide.

> Note: the IDE key is set via `.docker/xdebug.ini` file. By default, it is set to `docker`.

## Running xenforo CLI

If you want to use the xenforo CLI to it's full extent, you can execute it via the docker CLI to run within the PHP container

```sh
docker exec -it xenforo php cmd.php
```

It's important to keep the `-it` after docker exec, so that we attach to the output of the command in case there are any input prompts

## Xenforo reporting file inconsistencies

If you accidentally changed one of the core XF files during development, and you want to wipe and reinstall Xenforo source, just run `./install-from-zip.sh` and choose to wipe and unpack the source once again.

## Handy docker commands

To quickly kill the collection of containers

```sh
docker-compose kill
```

To remove/delete them

```sh
docker-compose rm
```

Kill/Remove from anywhere on the host

```sh
docker <kill/rm> $(docker ps -f name="xenforo*" -q)
```

Remove all associated volumes

```sh
docker volume rm $(docker volume ls -f name="xenforo*" -q)
```
