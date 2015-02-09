#!/bin/bash
# Gem Integratiion Test For Latest Rails App

BASEDIR=$(dirname $0)
cd "${BASEDIR}/.."
BASEDIR=$(pwd)

cd ..
gem install rails --no-ri --no-rdoc
rm -rf TestApp
rails new TestApp
cd TestApp

echo "gem 'colorgy_frontend', :path => '${BASEDIR}'" >> Gemfile
echo "gem 'compass-rails'" >> Gemfile
echo "gem 'rspec-rails'" >> Gemfile
echo "gem 'capybara-webkit'" >> Gemfile
bundle update -j4 -r3

mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
echo "@import 'colorgy/all';" >> app/assets/stylesheets/application.scss
echo "//= require colorgy/all" > app/assets/javascripts/application.js

bundle exec rake assets:precompile
