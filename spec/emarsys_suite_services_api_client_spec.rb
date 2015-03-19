require 'emarsys_suite_services_api_client'
require 'json'
require 'dotenv'

module Emarsys
  module Suite

    describe ServicesApiClient do
      before(:all) { Dotenv.load }

      let(:auth) { JSON.parse(ENV['AUTH']) }
      let(:client) { ServicesApiClient.new(auth['key'], auth['secret'], 'suite.ett.local', false) }
      let(:customer_id) { 122666592 }
      let(:integration_id) { 1 }

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
          expect(client.list_integrations(customer_id)).to include('integrations')
        end
      end

      describe '#get_integration' do
        it 'should get the specified integration' do
          expect(client.get_integration(customer_id, integration_id))
        end
      end
    end
  end
end
