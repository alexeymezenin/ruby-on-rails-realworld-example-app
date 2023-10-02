### Ruby On Rails implementation of RealWorld app

This Rails app is part of the [RealWorld](https://github.com/gothinkster/realworld) project.

You might also check [Laravel version](https://github.com/alexeymezenin/laravel-realworld-example-app) of this app.

See how the exact same Medium.com clone (called [Conduit](https://demo.realworld.io)) is built using different [frontends](https://codebase.show/projects/realworld?category=frontend) and [backends](https://codebase.show/projects/realworld?category=backend). Yes, you can mix and match them, because **they all adhere to the same [API spec](https://gothinkster.github.io/realworld/docs/specs/backend-specs/introduction)**

### How to run the API

Make sure you have Ruby and Rails installed on your computer.

Clone the repo and enter the project folder

```
git clone https://github.com/alexeymezenin/ruby-on-rails-realworld-example-app
cd ruby-on-rails-realworld-example-app
```

Install gems

```
bundle install
```

Execute migrations

```
rails db:migrate
```

Run the web server

```
rails server
```

That's it. Now you can use the api, i.e.

```
http://127.0.0.1:3000/api/articles
```
