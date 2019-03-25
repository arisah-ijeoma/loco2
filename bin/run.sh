#!/bin/bash

echo 'Installing bundler '2.0.1'...'
gem install bundler:2.0.1
bundle exec bundle
bundle exec rspec
./bin/search_info.rb
