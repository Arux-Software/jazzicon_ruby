# Jazzicon

[![Gem Version](https://badge.fury.io/rb/jazzicon.svg)](https://rubygems.org/gems/jazzicon)

This is a ruby port of https://github.com/danfinlay/jazzicon

> Say goodbye to boring blocky identicons that look like they came out of the 70s, and replace them with jazzy, colorful collages that more likely came out of the 80's.

![Example](https://github.com/Arux-Software/jazzicon_ruby/blob/main/examples.png?raw=true)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jazzicon'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jazzicon

## Usage

```ruby
require 'jazzicon'
Jazzicon::Icon.generate("random string or integer").save("icon.png")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Arux-Software/jazzicon_ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
