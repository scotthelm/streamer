# Streamer

The Streamer gem provides a configurable stream that takes a hash payload, and
performs functions on the hash, returning an instance of the stream with the
resulting payload.

The StreamBuilder uses a hash as configuration to string together the calls
that each stream makes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'streamer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install streamer

## Usage

This library transforms a hash. A StreamBuilder is fed a configuration hash
(usually a yaml file) that creates a chainable set of transformations using
the Stream object. The Stream has methods that are used to assign the results
of functions on the payload, back to the payload.

```ruby
sb = StreamBuilder.new(YAML.load(File.read('./config/config.yml')))
result = sb.transform
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake test` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/scotthelm/foo.This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Development
This gem includes a Docker environment for development. To begin development:

```bash
$ docker-compose build
$ docker-compose run --rm app gem install bundler && bundle install
```

This will create the data container for gems at /usr/local/bundle used inside
the app and guard containers.

To start guard in the background:

```bash
$ docker-compose up -d guard
```

To start guard in the foreground, leave off the `-d`. To start an interactive
session with the gem:

```bash
$ docker-compose run --rm app bin/console`
```

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

