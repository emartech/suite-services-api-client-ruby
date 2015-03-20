require 'rest-client'
require 'escher'

module Emarsys
  module Suite
    class ServicesApiClient

      def initialize(api_key, api_secret, host = 'api.emarsys.net', use_ssl = true)
        @api_key = api_key
        @api_secret = api_secret
        @host = host
        @protocol = use_ssl ? 'https' : 'http'
      end



      def healthcheck
        RestClient.get('http://suite.ett.local/api/services/healthcheck')
      end



      def authenticated_healthcheck
        uri = '/api/services/authenticated_healthcheck'
        request = sign_request('GET', uri)

        send_request(request, false)
      end



      def list_integrations(customer_id)
        uri = "/api/services/customers/#{customer_id}/integrations"
        request = sign_request('GET', uri)

        send_request(request)['integrations']
      end



      def get_integration(customer_id, integration_id)
        uri = "/api/services/customers/#{customer_id}/integrations/#{integration_id}"
        request = sign_request('GET', uri)

        send_request(request)['integration']
      end



      def update_integration(customer_id, integration_id, payload)
        uri = "/api/services/customers/#{customer_id}/integrations/#{integration_id}"
        request = sign_request('PUT', uri, payload)

        send_request(request)['integration']
      end



      private

      def url(uri)
        "#{@protocol}://#{@host}#{uri}"
      end



      def sign_request(method, uri, payload = nil)
        request = { method: method, uri: uri, headers: [['host', @host]]}
        if payload
          payload = JSON.generate(payload)
          request[:body] = payload
        end

        escher.sign!(request, client)

        request
      end



      def send_request(request, return_json = true)
        puts request.inspect
        response = (RestClient::Request.execute(
                       method: request[:method],
                       url: url(request[:uri]),
                       headers: request[:headers],
                       payload: request[:body],
                       ssl_version: :TLSv1
                   ))

        if return_json
          JSON.parse(response)
        else
          response
        end
      end



      def escher
        Escher::Auth.new('eu/suite/ems_request', {
             algo_prefix: 'EMS',
             vendor_key: 'EMS',
             auth_header_name: 'X-Ems-Auth',
             date_header_name: 'X-Ems-Date',
         })
      end



      def client
        {api_key_id: @api_key, api_secret: @api_secret}
      end

    end
  end
end
