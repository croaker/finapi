# frozen_string_literal: true

module FinAPI
  class EntityCollection
    include Enumerable

    def initialize(data, resource)
      @data = data
      @resource = resource
    end

    def each(&block)
      to_enum.each(&block)
    end

    def to_enum
      Enumerator.new do |yielder|
        loop do
          data[endpoint].each { |item| yielder.yield item }
          raise StopIteration unless next_page?

          @data = resource.all(page: current_page + 1)
        end
      end
    end

    def total_items
      data.dig("paging", "totalCount")
    end

    private

    attr_reader :data, :resource

    def next_page?
      current_page < total_pages
    end

    def current_page
      data.dig("paging", "page")
    end

    def total_pages
      total_items / per_page
    end

    def per_page
      data.dig("paging", "perPage")
    end

    def endpoint
      resource.endpoint
    end
  end
end
