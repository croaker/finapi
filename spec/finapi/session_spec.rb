# frozen_string_literal: true

require "spec_helper"

module FinAPI
  RSpec.describe FinAPI do
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
      end

      describe "#get" do
        it "delegates to the http_client" do
          http_client = double("http_client")
          session = FinAPI::Session.new("api_token", http_client)

          expect(http_client).to receive(:get)

          session.get("/test")
        end

        it "passes the url to the http_client" do
          http_client = double("http_client")
          session = FinAPI::Session.new("api_token", http_client)

          expect(http_client).to receive(:get).with("/test")

          session.get("/test")
        end

        it "passes any other param to the http_client" do
          http_client = double("http_client")
          session = FinAPI::Session.new("api_token", http_client)

          expect(http_client).to receive(:get).with("/test", foo: "bar")

          session.get("/test", foo: "bar")
        end
      end
    end
  end
end
