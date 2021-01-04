# AtariLegend Docker-based development environment

This is a Docker Compose setup used to develop for AtariLegend, both for the
[current site](https://github.com/atari-legend/atari-legend) and the
[legacy one / CPANEL](https://github.com/atari-legend/legacy).

## Setup

Clone this repository, then clone both the current site and legacy one:
- Clone the current site in a `site/` sub-folder
- Clone the legacy site in a `legacy/`  sub-folder

### Configuration

Some configuration is needed on both sides so that they know which URL to use to
reach the "other" site.

In your Laravel `site/.env` file for the main site, add:

```
# Base URL for the legacy site
AL_LEGACY_BASE_URL=http://localhost:8082
``` 

In the legacy site, create `legacy/public/php/config/local_settings.php`:

```php
<?php

define("FRONT_URL", "http://localhost:8080");
```

### Database connection

Follow the instructions in each of the repository READMEs. The database server
hostname is `mysql` and the database name and credentials can be found in the
`docker-compose.yml` file.

## Usage

Run the stack with `docker-compose up --build site`.

Additional containers are included that handle Composer, NPM, and Artisan
commands for the current site. Use the following command examples from your
project root, modifying them to fit your particular use case.

- `docker-compose run --rm composer update`
- `docker-compose run --rm npm run dev`
- `docker-compose run --rm artisan migrate` 

Similar container are available for the legacy site:

- `docker-compose run --rm legacy-npm run grunt`
- `docker-compose run --rm legacy-composer update`
