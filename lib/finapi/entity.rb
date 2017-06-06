# frozen_string_literal: true

require "string_refinements"

module FinAPI
  class Entity
    using StringRefinements

    def initialize(data)
      @data = data
    end

    private

    attr_reader :data

    def method_missing(method_name, *args, &block)
      requested_key = normalize_key(method_name)

      if data.key?(requested_key)
        retrieve_data(requested_key)
      else
        super
      end
    end

    def respond_to_missing?(method_name, _include_private = false)
      data.key?(normalize_key(method_name)) || super
    end

    def normalize_key(key)
      key.to_s.camelize
    end

    def retrieve_data(key)
      case value = data.fetch(key)
      when Hash then self.class.new(value)
      else value
      end
    end
  end
end
