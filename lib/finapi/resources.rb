# frozen_string_literal: true

module FinAPI
  class Resources
    def initialize(endpoint, session)
      @endpoint = endpoint
      @session = session
    end

    def find(id)
      response = session.get(specific_resource_path(id))

      Entity.new(parse_response(response))
    end

    private

    attr_reader :endpoint, :session

    def parse_response(response)
      JSON.parse(response.body)
    rescue NoMethodError, TypeError, JSON::ParserError
      {}
    end

    def specific_resource_path(id)
      "/api/v1/#{endpoint}/#{id}"
    end
  end
end
