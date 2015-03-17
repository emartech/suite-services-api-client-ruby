gem build emarsys_suite_services_api_client.gemspec
gem install emarsys_suite_services_api_client-0.0.1.gem
echo "require 'emarsys_suite_services_api_client'"
echo "client = Emarsys::Suite::ServicesApiClient.new 'asd', 'asd'"
irb
