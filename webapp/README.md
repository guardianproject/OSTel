# Devise Example for Rails 3

Example App using devise. http://github.com/plataformatec/devise

## Installation

Install bundler if you haven't yet:

```
gem install bundler
```

Install the gems:

```
bundle install
```

This will install Rails 3, sqlite3-ruby gem and Devise 1.4.7.

Rake devise setup task:

```
rake devise:setup
```

This will:

* drop any existing database
* create a new database
* migrate the database
* create a default user and admin

Run the server and use the credentials provided by the rake task to sign in and test the application.

## License

MIT License. Copyright 2010 Plataforma Tecnologia. http://blog.plataformatec.com.br
