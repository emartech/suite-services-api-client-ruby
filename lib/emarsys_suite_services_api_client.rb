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
        method = 'GET'
        uri = '/api/services/authenticated_healthcheck'
        request_data = assemble_request(method, uri)

        escher.sign!(request_data, client)

        send_request(method, request_data, uri, false)
      end



      def list_integrations(customer_id)
        method = 'GET'
        uri = "/api/services/customers/#{customer_id}/integrations"
        request_data = assemble_request(method, uri)

        escher.sign!(request_data, client)

        send_request(method, request_data, uri)['integrations']
      end



      def get_integration(customer_id, integration_id)
        method = 'GET'
        uri = "/api/services/customers/#{customer_id}/integrations/#{integration_id}"
        request_data = assemble_request(method, uri)

        escher.sign!(request_data, client)

        send_request(method, request_data, uri)['integration']
      end



      private

      def url(uri)
        "#{@protocol}://#{@host}#{uri}"
      end



      def assemble_request(method, uri)
        { method: method, uri: uri, headers: [['host', @host]] }
      end



      def send_request(method, request_data, uri, return_json = true)
        response = (RestClient::Request.execute(
                       method: method,
                       url: url(uri),
                       headers: request_data[:headers],
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
