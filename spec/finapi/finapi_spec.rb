# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe FinAPI do
    it "has a version number" do
      expect(FinAPI::VERSION).not_to eq(nil)
    end

    describe Session do
      describe ".new" do
        it "creates a new session" do
          expect(FinAPI::Session).to receive(:new).with("api_token")

          FinAPI::Session.new("api_token")
        end

        it "can use a custom http_client" do
          http_client = double("http_client")
          session = FinAPI::Session.new("api_token", http_client)

          expect(http_client).to receive(:get).with("/test")

          session.get("/test")
        end

        it "initializes faraday as the default client with the default url" do
          default_url = "https://sandbox.finapi.io"
          expect(Faraday).to receive(:new).with(default_url)

          FinAPI::Session.new("api_token")
        end
      end
    end

    describe "Resource instatiation" do
      it "instantiates a new resource from any method call" do
        http_client = double("http_client")
        session = FinAPI::Session.new("api_token", http_client)

        expect(FinAPI::Resources).to receive(:new).with(any_args)

        session.transactions
      end

      it "derives the endpoint from the method name" do
        http_client = double("http_client")
        session = FinAPI::Session.new("api_token", http_client)

        expect(FinAPI::Resources).to receive(:new).with(:transactions,
                                                        *any_args)

        session.transactions
      end

      it "passes the sessions http_client" do
        http_client = double("http_client")
        session = FinAPI::Session.new("api_token", http_client)

        expect(FinAPI::Resources).to receive(:new).with(:transactions,
                                                        http_client)

        session.transactions
      end

      it "only accepts known resources" do
        http_client = double("http_client")
        session = FinAPI::Session.new("api_token", http_client)

        expect {
          session.hulahula
        }.to raise_error(NoMethodError)
      end
    end
  end
end
