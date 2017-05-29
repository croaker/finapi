# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe Resources do
    describe "#find" do
      it "can receive a single item by id from the api" do
        http_client = double("http_client")
        response = double("response", body: nil)
        transactions = FinAPI::Resources.new(:transactions, http_client)

        expect(http_client)
          .to receive(:get).with(any_args) { response }

        transactions.find(123)
      end

      it "requests the resource from the correct uri" do
        http_client = double("http_client")
        response = double("response", body: nil)
        transactions = FinAPI::Resources.new(:transactions, http_client)

        expect(http_client)
          .to receive(:get).with("/api/v1/transactions/123") { response }

        transactions.find(123)
      end

      it "wraps the returned resource in an entity" do
        http_client = double("http_client")
        response = double("response", body: nil)
        transactions = FinAPI::Resources.new(:transactions, http_client)

        allow(http_client)
          .to receive(:get).with("/api/v1/transactions/123") { response }

        expect(transactions.find(123)).to be_instance_of(FinAPI::Entity)
      end

      it "returns the requested resource" do
        http_client = double("http_client")
        response = double("response",
                          body: File.read("./spec/fixtures/transaction.json"))
        transactions = FinAPI::Resources.new(:transactions, http_client)

        expect(http_client).to receive(:get)
          .with("/api/v1/transactions/123")
          .and_return(response)

        expect(transactions.find(123).id).to eq(21271018)
      end
    end
  end
end
