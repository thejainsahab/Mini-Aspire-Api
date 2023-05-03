# MINI ASPIRE API

## Install

### Clone the repository

```shell
git clone git@github.com:thejainsahab/Mini-Aspire-Api.git
cd mini-aspire-api
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.5`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.5
```

### Do everything automatically

```shell
./bin/setup
```

OR

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```