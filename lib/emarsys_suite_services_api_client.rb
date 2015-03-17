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
        request_data = {
            method: 'GET',
            uri: '/api/services/authenticated_healthcheck',
            headers: [['host', @host]],
        }

        escher.sign!(request_data, client)

        RestClient::Request.execute(
            method: :get,
            url: "#{@protocol}://#{@host}/api/services/authenticated_healthcheck",
            headers: request_data[:headers],
            ssl_version: :TLSv1
        )
      end



      def list_integrations(customer)
        request_data = {
            method: 'GET',
            uri: "/api/services/customers/#{customer}/integrations",
            headers: [['host', @host]],
        }

        escher.sign!(request_data, client)

        RestClient::Request.execute(
          method: 'GET',
          url: "#{@protocol}://#{@host}/api/services/customers/#{customer}/integrations",
          headers: request_data[:headers],
          ssl_version: :TLSv1
        )
      end



      private
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
