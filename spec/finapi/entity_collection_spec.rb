# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe EntityCollection do
    it "expects an iterable collection at the given key in the data" do
      data = { "test" => [],
               "paging" => { "totalCount" => 0, "perPage" => 1, "page" => 1 } }
      resource = double("resource", endpoint: "test")
      ec = EntityCollection.new(data, resource)

      expect(ec).to match_array([])
    end

    it "can iterate over a whole data set with successive requests" do
      page1 = { "test" => [1,2],
                "paging" => { "page" => 1, "perPage" => 2, "totalCount" => 4 }}
      page2 = { "test" => [3,4],
                "paging" => { "page" => 2, "perPage" => 2, "totalCount" => 4 }}
      resource = double("resource", endpoint: "test")
      ec = EntityCollection.new(page1, resource)

      expect(resource).to receive(:all)
        .with(page: 2)
        .and_return(page2)

      ec.to_a
    end

    describe "#total_items" do
      it "returns the total number of items according to the response" do
        data = { "paging" => { "totalCount" => 10 }}
        resource = double("resource")
        ec = EntityCollection.new(data, resource)

        expect(ec.total_items).to eq(10)
      end
    end
  end
end
