#!/bin/bash

export RAILS_ENV=test
bundle install --with development test
rails db:create
rails db:migrate
rspec

