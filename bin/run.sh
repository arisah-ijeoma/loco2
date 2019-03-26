#!/bin/bash

echo 'Installing bundler '2.0.1'...'
gem install bundler:2.0.1
bundle install
rspec

echo '*******************'
echo 'Setup complete'
echo '*******************'

./bin/search_info.rb
