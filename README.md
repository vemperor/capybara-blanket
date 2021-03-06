# Capybara::Blanket

[![Build Status](https://travis-ci.org/vemperor/capybara-blanket.svg?branch=master)](https://travis-ci.org/vemperor/capybara-blanket)
[![Coverage Status](https://coveralls.io/repos/vemperor/capybara-blanket/badge.png?branch=master)](https://coveralls.io/r/vemperor/capybara-blanket?branch=master)

Originally developed by [Keyvan Fatehi](https://github.com/keyvanfatehi) as [cucumer-blanket](https://github.com/keyvanfatehi/cucumber-blanket).

Works to extract accumulated [Blanket.js](https://github.com/alex-seville/blanket) coverage data
from the browser from a Capybara environment. Accumulated, in this context, means that coverage data
is accumulated from scenario to scenario, in an additive fashion.

This gem supports rails 4.0 and newer.

## Installation

Add to your gemfile:

    gem 'capybara-blanket', git: 'https://github.com/vemperor/capybara-blanket.git'

## Usage

Supports minitest only for now.

To use this gem, you need to add those lines in your test_helper:

    require 'capybara/blanket'
    require 'capybara/blanket/minitest'

If you use asset pipeline, you need to divide your js files vendor files and application, so you wont get vendor files coverage.

Then add 'data-cover' attriute to all files you need coverage for:

    ...
    = javascript_include_tag "vendor"
    = javascript_include_tag "application", "data-cover" => true
    ...

Then you need to add 'blanket' and 'capybara-blanket' files to you template:

    = javascript_include_tag 'blanket'
    = javascript_include_tag 'capybara-blanket'

After all, you need to get coverage data after every page visiting in your tests like this:

    page = visit '/sessions/new'
    Capybara::Blanket.extract_from page

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
