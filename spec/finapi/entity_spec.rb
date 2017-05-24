# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe Entity do
    describe "exposing underlying data as methods" do
      it "exposes keys as methods" do
        data = JSON.parse(File.read("spec/fixtures/transaction.json"))
        entity = FinAPI::Entity.new(data)

        expect(entity.id).to eq(21271018)
      end

      it "only responds to keys in the data" do
        entity = FinAPI::Entity.new({})

        expect {
          entity.id
        }.to raise_error(NoMethodError)
      end
    end

  end
end
