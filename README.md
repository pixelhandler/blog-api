# Blog API

JSON API following [jsonapi.org] spec for a blog application with auth for creating and editing post resources

* .ruby-version is setup for 2.2.2
* Project created with [rails-api] gem (so no view layer, JSON is the view)
* Serialization of models (to JSON) is done with the [jsonapi-resources] gem
  * Using ActiveRecord is the happy path for now, I used the pg gem, for [PostgreSQL]


## Setup

* `bundle` install the gems

* Database creation, I used the [Postgres app] and had to configure bundle:

    bundle config build.pg --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.4/bin/pg_config

### Config

Copy the config/database.example.yml config/secrets.example.yml files to:
config/database.yml config/secrets.yml 

In the database.example.yml file the password is set to and environemnt variables:
BLOG_API_DB_USR and BLOG_API_DB_PWORD. set your environment variables, or replace them
with your db credentials

    export BLOG_API_DB_USR='blog-api'
    export BLOG_API_DB_PWORD='XXXX'

* DB role 'blog-api'

Setup a Postgress role: 'blog-api'

* http://postgresapp.com
* https://eggerapps.at/pgcommander/

    CREATE ROLE api WITH SUPERUSER LOGIN PASSWORD 'XXXX';
    CREATE DATABASE blog_api_development OWNER blog-api;
    CREATE DATABASE blog_api_test OWNER blog-api;

* `bundle exec rake db:setup`
* See the seeds file to create resources for a post, author, and user


## Tests

* `bundle exec rspec` 


## Notes / Reference

* Slugs: <http://code-worrier.com/blog/custom-slugs-in-rails/>
* Token Auth:
  * <http://adamalbrecht.com/2014/12/04/add-json-web-token-authentication-to-your-angular-rails-app/>
  * <http://robert-reiz.com/2014/04/12/has_secure_password-with-rails-4-1/>

[jsonapi.org]: http://jsonapi.org
[rails-api]: https://github.com/rails-api/rails-api
[PostgreSQL]: http://www.postgresql.org
[Postgres app]: http://postgresapp.com
[jsonapi-resources]: https://github.com/cerebris/jsonapi-resources
