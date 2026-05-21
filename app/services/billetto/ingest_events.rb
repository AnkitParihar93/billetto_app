# app/services/billetto/ingest_events.rb

module Billetto
  class IngestEvents
    def call
      events = FetchEvents.new.call

      events.each do |e|
        Event.find_or_create_by(external_id: e["id"]) do |event|
          event.title = e["title"]
          event.description = e["description"]
          event.date = e["date"]
          event.image_url = e["image"]
          event.upvotes = 0
          event.downvotes = 0
        end
      end
    end
  end
end