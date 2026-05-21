require "rails_helper"

RSpec.describe Votes::CastVote do
  let(:event_record) { Event.create!(title: "Test",external_id: "external_id", date: Time.now) }
  let(:user) { { "sub" => "user_1" } }

  it "publishes upvote event" do
    service = described_class.new(
      event: event_record,
      user: user,
      type: :upvote
    )

    expect {
      service.call
    }.not_to raise_error
  end
end