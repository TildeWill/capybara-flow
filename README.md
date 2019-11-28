Capybara::Flow
=

Take a peak at your headless browser acceptance tests. Capybara::Flow captures screenshots after Capybara driven user actions in order to compose an animation of your scenario.

## Installation

Capybara::Flow depends on ImageMagick. On newer versions of OS X installation is simple: 
```
brew unlink imagemagick #if you already have imagemagick installed
brew install imagemagick@6 && brew link imagemagick@6 --force
```

Add this line to your application's Gemfile:

    gem 'capybara-flow', group: :test

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara-flow

## Usage

`Capybara::Flow` automatically hooks in to RSpec system tests with the tag `:js`. 
It depends on a driver that implements ```#save_screenshot```

## Configuration

Add the following to `spec/support/capybara_flow.rb`

```ruby
require 'capybara/flow/hooks/rspec'

Capybara::Flow.configure do |config|
  config.save_path = Rails.root.join("tmp/flow")
  config.iterations = 1
  config.delay_in_ms = 700
end

```

## Credit

This is forked from https://github.com/surzycki/capybara-animate 

