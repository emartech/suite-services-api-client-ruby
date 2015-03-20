Gem::Specification.new do |s|
  s.name        = 'emarsys_suite_services_api_client'
  s.version     = '0.0.4'
  s.date        = '2015-03-16'
  s.summary     = 'Client for the services api of the Emarsys Suite'
  s.description = 'Client for the services api of the Emarsys Suite.'
  s.authors     = 'Emarsys'
  s.email       = 'andras.barthazi@emarsys.com'
  s.files       = ['lib/emarsys_suite_services_api_client.rb']
  s.homepage    = 'https://github.com/emartech/suite-services-api-client-ruby'
  s.license     = 'MIT'

  s.add_dependency 'rest-client', '1.7.3'
  s.add_dependency 'escher', '0.3.2'

  s.add_development_dependency 'rspec', '3.2.0'
  s.add_development_dependency 'dotenv', '1.0.2'

end
