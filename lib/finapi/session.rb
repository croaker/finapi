# frozen_string_literal: true

module FinAPI
  class Session
    def initialize(api_token, http_client = nil)
      @http_client = http_client || default_client
    end

    def get(url)
      http_client.get(url)
    end

    private

    attr_reader :http_client

    def default_client
      Faraday.new("https://sandbox.finapi.io")
    end
  end
end
