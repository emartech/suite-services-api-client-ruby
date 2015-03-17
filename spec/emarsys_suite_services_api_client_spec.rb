require 'emarsys_suite_services_api_client'
require 'json'

module Emarsys
  module Suite
    describe ServicesApiClient do
      let(:keypool) { JSON.parse(ENV['KEY_POOL']) }
      let(:client) { ServicesApiClient.new(keypool['key'], keypool['value'], 'suite.ett.local', false) }

      describe '#healthcheck' do
        it 'should return OK' do
          expect(client.healthcheck).to eq('OK')
        end
      end

      describe '#authenticated_healthcheck' do
        it 'should return OK' do
          expect(client.authenticated_healthcheck).to eq('OK')
        end
      end

      describe '#list_integrations' do
        it 'should get the integrations and their state' do
          expect(client.list_integrations(122666592)).to include('integrations', 'is_on')
        end
      end
    end
  end
end
