# Streamer

[![Build Status](https://travis-ci.org/scotthelm/streamer.svg?branch=master)](https://travis-ci.org/scotthelm/streamer)

[![Code Climate](https://codeclimate.com/github/scotthelm/streamer/badges/gpa.svg)](https://codeclimate.com/github/scotthelm/streamer)

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

Please have a look at the [examples](./examples) directory for some simple
sample usage

## Development
This gem includes a Docker environment for development. To begin development:

```bash
$ script/init
```

This will create the data container for gems at /usr/local/bundle used inside
the app and guard containers.

To start guard in the background:

```bash
$ script/guard
```

To start guard in the foreground, 

```bash
script/test
```

To start an interactive session with the gem:

```bash
script/console
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/scotthelm/streamer. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

