# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe EntityCollection do
    it "expects an iterable collection at the given key in the data" do
      data = { "test" => [] }
      ec = EntityCollection.new(data, :test)

      expect(ec).to match_array([])
    end

    describe "#total_items" do
      it "returns the total number of items in the collection" do
        data = { "test" => [] }
        ec = EntityCollection.new(data, :test)

        expect(ec.total_items).to be_zero
      end
    end
  end
end
