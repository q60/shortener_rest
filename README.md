# shortener REST

A simple REST API for shortening URLs using Open Page Rank API for URL lifetime and PostgreSQL as a database.

## Usage

1. clone the repository
2. handle application secrets
```sh
$ mix phx.gen.secret
YOUR_SECRET
$ export SECRET_KEY_BASE=YOUR_SECRET
```
3. configure your database
```sh
$ createdb yourDB
$ export DATABASE_URL=ecto://USER:PASS@HOST/yourDB
```
4. configure your OPR API key
```sh
$ export OPR_API_KEY=YOUR_KEY
```
5. setup project deps, compile
```sh
$ mix deps.get --only prod
$ MIX_ENV=prod mix compile
```
6. perform DB migration
```sh
$ MIX_ENV=prod mix ecto.migrate
```
7. you're ready to use it!
```sh
$ PORT=4000 MIX_ENV=prod mix phx.server
```