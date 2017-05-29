# frozen_string_literal: true

module FinAPI
  class Session
    def initialize(api_token, http_client = nil)
      @api_token = api_token
      @http_client = http_client || default_client
    end

    def get(url)
      http_client.get(url)
    end

    private

    attr_reader :api_token, :http_client

    def method_missing(method_name, *args, &block)
      if endpoints.include?(method_name)
        FinAPI::Resources.new(method_name, http_client)
      else
        super
      end
    end

    def respond_to_missing?(method_name, _include_private = false)
      endpoints.include?(method_name) || super
    end

    def endpoints
      %i[transactions]
    end

    def default_client
      # No idea wheter the tap is really necessary, passing just the block
      # fails for the authorization though
      Faraday.new(url: "https://sandbox.finapi.io").tap do |conn|
        conn.authorization :Bearer, api_token
      end
    end
  end
end
