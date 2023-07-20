# Blog API

JSON API following [jsonapi.org] spec for a blog application with auth for creating and editing post resources

* .ruby-version is setup for 3.0.6
* Serialization of models (to JSON) is done with the [jsonapi-resources] gem
  * Use ActiveRecord and the `pg` gem for [PostgreSQL]

## Setup

* `bundle` to install the gems
* `mkdir -p shared/log && mkdir -p shared/pids && mkdir -p shared/sockets`

### Config

Copy the config/database.example.yml config/secrets.example.yml files to:
config/database.yml config/secrets.yml

In the database.example.yml file the password is set to and environemnt variables:
BLOG_API_DB_USR and BLOG_API_DB_PWORD. set your environment variables, or replace them
with your db credentials

    export BLOG_API_DB_USR='blog_api'
    export BLOG_API_DB_PWORD='XXXX'

* DB role 'blog_api'

Setup a Postgress role: 'blog_api'

    createuser -P -s -e blog_api
    createdb blog_api_development -O blog_api

Or,

    PGUSER=$BLOG_API_DB_USR PGPASSWORD=$BLOG_API_DB_PWORD psql -h localhost -p 5432 blog_api_development

    CREATE ROLE blog_api WITH SUPERUSER LOGIN PASSWORD 'X';
    CREATE DATABASE blog_api_development OWNER blog_api;
    CREATE DATABASE blog_api_test OWNER blog_api;


* `bundle exec rake db:setup`
* See the seeds file to create resources for a post, author, and user

### Seeds

Copy the db/seeds.example.rb and add records for an user, author and posts

## Restore DB from production

1) Use tunnel

    ssh -fNg -L 54321:127.0.0.1:5432 pixelhandler.com
    lsof -i tcp | grep ^ssh

2) Dump database (use pword from prod)

    current_time=$(date "+%Y.%m.%d-%H.%M.%S"); pg_dump -U $BLOG_API_DB_PROD_USR -h localhost -p 54321 $BLOG_API_DB_PROD > $BLOG_API_DB_PROD"."$current_time".sql"

3) Drop and create

    bin/rails db:drop
    bin/rails db:create

4) Import

    PGUSER=$BLOG_API_DB_USR PGPASSWORD=$BLOG_API_DB_PWORD psql -h localhost -p $BLOG_API_DB_PORT blog_api_development < blog_api_production.sql

## Docker For PostgreSQL

- https://docs.docker.com/engine/examples/postgresql_service/#installing-postgresql-on-docker

    docker build -t eg_postgresql .
    docker run --rm -P --name pg_test eg_postgresql
    docker ps
    psql -h localhost -p 32768 -d docker -U docker --password

`docker` is the pword.

## Notes / Reference

* Slugs: <http://code-worrier.com/blog/custom-slugs-in-rails/>
* Token Auth:
  * <http://adamalbrecht.com/2014/12/04/add-json-web-token-authentication-to-your-angular-rails-app/>
  * <http://robert-reiz.com/2014/04/12/has_secure_password-with-rails-4-1/>

[jsonapi.org]: http://jsonapi.org
[PostgreSQL]: http://www.postgresql.org
[jsonapi-resources]: https://github.com/cerebris/jsonapi-resources
