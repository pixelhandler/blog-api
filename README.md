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

In the database.yml file the password is set to and environemnt variable: BLOG_API_DB_PWORD

	export BLOG_API_DB_PWORD='XXXX'

* DB role 'api'

Setup a Postgress db for api_blog_api and a role: 'api'

* http://postgresapp.com
* https://eggerapps.at/pgcommander/

    CREATE ROLE api WITH SUPERUSER LOGIN PASSWORD 'XXXX';
    CREATE DATABASE api_development OWNER api;
    CREATE DATABASE api_test OWNER api;

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