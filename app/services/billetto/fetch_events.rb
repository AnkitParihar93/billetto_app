# app/services/billetto/fetch_events.rb
require "http"
require "json"

module Billetto
  class FetchEvents
    API_URL = "https://billetto.dk/api/v3/organiser/events"

    def call
      response = HTTP
        .headers(
          "Accept" => "application/json",
          "Api-Keypair" => "#{ENV['BILLETTO_ACCESS_KEY_ID']}:#{ENV['BILLETTO_ACCESS_KEY_SECRET']}"
        )
        .get(API_URL)
        
      raise "API failed: #{response.status}" unless response.status.success?

      JSON.parse(response.body.to_s)
    end
  end
end