# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe FinAPI do
    it "has a version number" do
      expect(FinAPI::VERSION).not_to eq(nil)
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
