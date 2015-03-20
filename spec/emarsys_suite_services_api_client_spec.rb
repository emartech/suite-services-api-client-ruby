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
      let(:integration_id) { 'powerinbox' }

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
          expect(client.list_integrations(customer_id)).to be_instance_of(Array)
        end
      end

      describe '#get_integration' do
        it 'should get the specified integration' do
          expect(client.get_integration(customer_id, integration_id)).to be_instance_of(Hash)
        end
      end

      describe '#update_integration' do
        it 'turns on the specified integration' do
          expect(client.update_integration(customer_id, integration_id, { is_on: true }))
        end

        it 'turns off the specified integration' do
          expect(client.update_integration(customer_id, integration_id, { is_on: false }))
        end
      end

    end

  end
end
