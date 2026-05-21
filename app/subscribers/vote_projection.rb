class VoteProjection
  def call(event)
    record = Event.find(event.data[:event_id])

    case event.class.name
    when "EventUpvoted"
      record.increment!(:upvotes)
    when "EventDownvoted"
      record.increment!(:downvotes)
    end
  end
end