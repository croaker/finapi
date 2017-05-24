# frozen_string_literal: true

module FinAPI
  class Entity

    def initialize(data)
      @data = data
    end

    def method_missing(method_name, *args, &block)
      requested_key = method_name.to_s

      if data.key?(requested_key)
        data.fetch(requested_key)
      else
        super
      end
    end

    def respond_to_missing?(method_name, _include_private = false)
      data.key?(method_name.to_s) || super
    end

    private

    attr_reader :data

  end
end
