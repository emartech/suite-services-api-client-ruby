#!/usr/bin/env bash

gem build emarsys_suite_services_api_client.gemspec
gem install emarsys_suite_services_api_client-0.0.2.gem
echo "require 'emarsys_suite_services_api_client'"
echo "client = Emarsys::Suite::ServicesApiClient.new 'developer', 'MzhKUxb2vlHGfJgAMEaVIWyk5BBFilrg', 'suite.ett.local', false"
irb
