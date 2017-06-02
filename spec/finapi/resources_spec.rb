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

    describe "#all" do
      it "requests from the collection path" do
        session = double("session")
        response = double("response", body: nil)
        transactions = FinAPI::Resources.new(:transactions, session)
        expect(session)
          .to receive(:get).with("/api/v1/transactions") { response }

        transactions.all
      end

      it "returns a collection of items" do
        session = double("session")
        transactions = FinAPI::Resources.new(:transactions, session)
        response = double("response",
                          body: File.read("./spec/fixtures/transactions.json"))

        allow(session)
          .to receive(:get).with(any_args) { response }

        expect(transactions.all.total_items).to eq(912)
      end

      it "passes arguments to the session" do
        session = double("session")
        transactions = FinAPI::Resources.new(:test, session)

        expect(session).to receive(:get).with("/api/v1/test", foo: "bar")

        transactions.all(foo: "bar")
      end
    end

    describe "#parse_response" do
      it "returns the parsed response.body" do
        response_body = File.read("./spec/fixtures/transaction.json")
        parsed_response = JSON.parse(response_body)
        response = double("response", body: response_body)
        resource = FinAPI::Resources.new(:test, nil)

        expect(resource.parse_response(response)).to eq(parsed_response)
      end

      context "malformed responses" do
        it "returns an empty hash on NoMethodError" do
          response = {}
          resource = FinAPI::Resources.new(:test, nil)

          expect{ response.body }.to raise_error(NoMethodError)
          expect(resource.parse_response(response)).to eq({})
        end

        it "returns an empty hash on TypeError" do
          response = double("response", body: nil)
          resource = FinAPI::Resources.new(:test, nil)

          expect{ JSON.parse(response.body) }.to raise_error(TypeError)
          expect(resource.parse_response(response)).to eq({})
        end

        it "returns an empty hash on JSON::ParserError" do
          response = double("response", body: "")
          resource = FinAPI::Resources.new(:test, nil)

          expect{ JSON.parse(response.body) }.to raise_error(JSON::ParserError)
          expect(resource.parse_response(response)).to eq({})
        end
      end
    end
  end
end
