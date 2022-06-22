# Project

[Finance_tracker](https://finance-tracker-team-c.herokuapp.com/)
[GitHub](https://github.com/Shkuryn/finance_tracker)

## Install

### Clone the repository

```shell
git clone git@github.com:Shkuryn/finance_tracker.git
cd finance_tracker
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.0.3`

If not, install the right ruby version using [rvm](https://rvm.io/) (it could take a while):

```shell
rvm install 3.0.3
```
### Install dependencies

Using [Bundler](https://github.com/bundler/bundler), [Yarn](https://github.com/yarnpkg/yarn) and [Node.js](https://nodejs.org/en/)

```shell
bundle 
```
```shell
install yarn 
```
```shell
install node.js 
```
```shell
 bundle exec rake webpacker:install
```
### Initialize the database

```shell
rails db:create db:migrate db:seed
```

### Add heroku remotes

Using [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```shell
heroku git:remote -a finance_tracker
heroku git:remote --remote heroku-staging -a finance_tracker-staging
```

## Serve

```shell
rails s
```

## Deploy

### With Heroku pipeline (recommended)

Push to Heroku staging remote:

```shell
git push heroku-staging
```

Go to the Heroku Dashboard and [promote the app to production](https://devcenter.heroku.com/articles/pipelines) or use Heroku CLI:

```shell
heroku pipelines:promote -a finance_tracker-staging
```

### Directly to production (not recommended)

Push to Heroku production remote:

```shell
git push heroku
```

