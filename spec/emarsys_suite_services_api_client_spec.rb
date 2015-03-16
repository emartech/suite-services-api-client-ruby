require 'emarsys_suite_services_api_client'

module Emarsys
  module Suite
    describe ServicesApiClient do
      let(:client) { ServicesApiClient.new('developer', 'MzhKUxb2vlHGfJgAMEaVIWyk5BBFilrg', 'suite.ett.local', false) }
      it 'should send a request' do
        expect(client.healthcheck).to eq('OK')
      end
      it 'should send an authenticated request' do
        expect(client.authenticated_healthcheck).to eq('OK')
      end
    end
  end
end
