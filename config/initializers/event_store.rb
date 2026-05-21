Rails.application.config.to_prepare do
  Rails.configuration.event_store =
    RailsEventStore::Client.new

  Rails.configuration.event_store.subscribe(
    VoteProjection.new,
    to: [EventUpvoted, EventDownvoted]
  )
end