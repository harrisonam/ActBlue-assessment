# Voting app for interview exercises

This Rails application is the starting point for several different interview exercises. You may not need all the various models, controllers, etc. in order to complete the exercise assigned, but they are here in case they help you move faster!
Please modify anything and everything you need to in order to meet exercise
requirements and show us your own approach.

## Installation

Your development environment should have:

* Ruby v2.7 or higher
* [Bundler](https://bundler.io/)
* git
* [SQLite3](https://www.sqlite.org/)

Initialize git, install the application, and initialize the database:

```sh
# First, download the zip file, unzip the directory,
# and navigate into the project directory. Then:
git init
git add .
git commit -m "Initial files provided"
bundle install
bundle exec rake db:migrate
```

## Seeding the database with sample data

Optionally, you can run the seed scripts to generate some sample data:

```sh
bundle exec rails db:seed
```


## Running the app

```sh
bundle exec rails server
```

Visit [http://localhost:3000](http://localhost:3000) in your browser

## Running tests

The included test suite uses Rspec and Capybara.

Check out `spec/requests/` for example tests.

```sh
# Run all tests
bundle exec rspec

# Run one test file
bundle exec rspec <path/to/the/file.rb>

# Run one test case inside a test file
bundle exec rspec <path/to/the/file.rb>:<line_number>
```

## Accessing the Rails console

```sh
bundle exec rails console
```

## Debugging

You can open up a debugging console by adding `binding.pry` anywhere in test or application code.

Example:

```rb
def show
    binding.pry
    render json: { data: @poll }, status: :ok
end
```

In this example, when the `show` method is hit during click testing or a test, a debugger will open up in the terminal, where you can inspect values:

```rb
@poll.id
@poll.valid?
```

Step to the next line with `next`. Resume regular code execution or tests with `continue`.
