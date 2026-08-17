# AtariLegend Docker-based development environment

This is a Docker Compose setup used to develop for the AtariLegend
[site](https://github.com/atari-legend/atari-legend).

## Setup

Clone this repository, then clone the site in a `site/` sub-folder.

### Configuration

Leave `AL_LEGACY_BASE_URL` unset in `site/.env`: it falls back to
`http://legacy.atarilegend.com`, which is where the database dumps the site
links to are actually served from.

### Database connection

Follow the instructions in the site's own README. The database server is
MariaDB 10.11, reachable as `db` on the Compose network, and the database name
and credentials can be found in the `docker-compose.yml` file. The main site
connects to it with Laravel's `mariadb` driver, so use `DB_HOST=db` and
`DB_CONNECTION=mariadb` in `site/.env`.

The `db` service has no volume: its data lives in the container layer and is
lost whenever the container is recreated (`docker compose down`, an image
change). Build an empty schema with

```
docker compose run --rm artisan migrate:fresh
```

and restore a dump into it for anything to look at.

## Usage

Run the stack with `docker-compose up --build site`.

Additional containers are included that handle Composer, NPM, and Artisan
commands. Use the following command examples from your project root, modifying
them to fit your particular use case.

- `docker-compose run --rm composer update`
- `docker-compose run --rm npm run dev`
- `docker-compose run --rm artisan migrate` 
