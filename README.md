# Rack::Relativize

rack-relativize relativize path of html ( href, src attribute) and css ( url(..) ).

This middleware is port of Nanoc::Filters::RelativizePaths.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-relativize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-relativize

## Usage

config.ru

    use Rack::Relativize

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
