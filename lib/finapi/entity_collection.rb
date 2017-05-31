# frozen_string_literal: true

module FinAPI
  class EntityCollection
    include Enumerable

    def initialize(data, collection_at)
      @data = data
      @collection_at = collection_at.to_s
    end

    def each(&block)
      @data[@collection_at].each(&block)
    end

    def total_items
      each.size
    end
  end
end
