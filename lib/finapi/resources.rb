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

    def all(params = {})
      response = session.get(collection_resource_path, params)
      data = parse_response(response)
      size = data.dig("paging", "totalCount")
      page = data.dig("paging", "page")
      pages = data.dig("paging", "pageCount")

      Enumerator.new(size) do |yielder|
        loop do
          data[endpoint.to_s].each { |item| yielder.yield Entity.new(item) }
          raise StopIteration unless page < pages

          response = session.get(collection_resource_path,
                                 params.merge(page: page += 1))
          data = parse_response(response)
        end
      end
    end

    def parse_response(response)
      JSON.parse(response.body)
    rescue NoMethodError, TypeError
      {}
    end

    private

    attr_reader :endpoint, :session

    def specific_resource_path(id)
      "#{endpoint_path}/#{id}"
    end

    def collection_resource_path
      endpoint_path
    end

    def endpoint_path
      "/api/v1/#{endpoint}"
    end
  end
end
