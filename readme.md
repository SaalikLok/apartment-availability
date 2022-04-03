# Apartment Availability

This is a command line script that scrapes apartment availabilities for particular floor plans that we're interested in moving into, printing it into a nice command line table.
Instead of checking these pages daily, this scraper surfaces relevant information whenever it's run.

## Running Locally

Ensure that you have [Ruby 3.1.1](https://www.ruby-lang.org/en/news/2022/02/18/ruby-3-1-1-released/) installed.

1. Clone this repository
2. In this directory, install dependencies: `bundle install`

Print the table to the terminal with a Rake task:

```
bundle exec rake print_apartments
```

### Built with

* [Terminal Table](https://github.com/tj/terminal-table)
* [Colorize](https://github.com/fazibear/colorize)
* [Nokogiri](https://github.com/sparklemotion/nokogiri)

### Life made easier by

* [StandardRB](https://github.com/testdouble/standardrb)
* [Pry](http://pry.github.io/)
