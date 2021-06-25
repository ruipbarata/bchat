#!/bin/bash

# Remove a potentially pre-existing server.pid for Rails.
rm -f /project/tmp/pids/server.pid || true

bundle install
rails assets:precompile

rails db:migrate
rails log:clear tmp:clear
bundle exec rails s -p 3000 -b '0.0.0.0'
