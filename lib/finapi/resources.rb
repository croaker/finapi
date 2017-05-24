# frozen_string_literal: true

module FinAPI
  class Resources
    def initialize(endpoint, http_client)
      @endpoint = endpoint
      @http_client = http_client
    end

    def find(id)
      http_client.get(single_resource_uri(id))

      Entity.new
    end

    private

    attr_reader :endpoint, :http_client

    def single_resource_uri(id)
      "/api/v1/#{endpoint}/#{id}"
    end
  end
end
