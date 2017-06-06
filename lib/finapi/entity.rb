# frozen_string_literal: true

require "string_refinements"

module FinAPI
  class Entity
    using StringRefinements

    def initialize(data)
      @data = data
    end

    def method_missing(method_name, *args, &block)
      requested_key = method_name.to_s.camelize

      if data.key?(requested_key)
        retrieve_data(requested_key)
      else
        super
      end
    end

    def respond_to_missing?(method_name, _include_private = false)
      data.key?(method_name.to_s) || super
    end

    private

    attr_reader :data

    def retrieve_data(key)
      result = data.fetch(key)

      case result
      when Hash
        self.class.new(result)
      else
        result
      end
    end
  end
end
