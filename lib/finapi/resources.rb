# frozen_string_literal: true

module FinAPI
  class Resources
    def initialize(endpoint, http_client)
      @endpoint = endpoint
      @http_client = http_client
    end

    def find(id)
      data = http_client.get(specific_resource_path(id))

      Entity.new(JSON.parse(data.body || "{}"))
    end

    private

    attr_reader :endpoint, :http_client

    def specific_resource_path(id)
      "/api/v1/#{endpoint}/#{id}"
    end
  end
end
