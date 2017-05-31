# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe FinAPI do
    it "has a version number" do
      expect(FinAPI::VERSION).not_to eq(nil)
    end

    describe "default http client" do
      it "uses connects with provided api key in authorization headers" do
        stub = stub_request(:get, "https://sandbox.finapi.io/123")
                 .with(headers: { "Authorization" => "Bearer Secret Token" })

        session = FinAPI::Session.new("Secret Token")
        session.get("/123")

        expect(stub).to have_been_requested
      end
    end

    describe "Session and Resources interaction" do
      it "instantiates a new resource from any method call" do
        session = FinAPI::Session.new("api_token")

        expect(FinAPI::Resources).to receive(:new).with(any_args)

        session.transactions
      end

      it "derives the endpoint from the method name" do
        session = FinAPI::Session.new("api_token")

        expect(FinAPI::Resources).to receive(:new).with(:transactions,
                                                        *any_args)

        session.transactions
      end

      it "passes the session" do
        session = FinAPI::Session.new("api_token")

        expect(FinAPI::Resources).to receive(:new).with(:transactions,
                                                        session)

        session.transactions
      end

      it "only accepts known resources" do
        session = FinAPI::Session.new("api_token")

        expect {
          session.hulahula
        }.to raise_error(NoMethodError)
      end
    end
  end
end
