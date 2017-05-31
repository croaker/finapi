# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe Resources do
    describe "#find" do
      let(:session) { double("session") }
      let(:transactions) { FinAPI::Resources.new(:transactions, session) }

      context "with an arbitrary response" do
        let(:response) { double("response", body: nil) }

        it "can receive a specific item by id" do
          expect(session)
            .to receive(:get).with(any_args) { response }

          transactions.find(123)
        end

        it "requests with the correct path" do
          expect(session)
            .to receive(:get).with("/api/v1/transactions/123") { response }

          transactions.find(123)
        end

        it "wraps the resource in an entity" do
          allow(session)
            .to receive(:get).with("/api/v1/transactions/123") { response }

          expect(transactions.find(123)).to be_instance_of(FinAPI::Entity)
        end
      end

      context "with a specific response" do
        it "returns specific resource" do
          response = double("response",
                            body: File.read("./spec/fixtures/transaction.json"))

          allow(session).to receive(:get)
            .with("/api/v1/transactions/123")
            .and_return(response)

          expect(transactions.find(123).id).to eq(21271018)
        end
      end
    end
  end
end
