require "rails_helper"

RSpec.describe "Clerk Authentication API", type: :request do
  let(:event) { Event.create!(title: "Test",external_id: "external_id", date: Time.now) }

  it "rejects request without login" do
    post upvote_event_path(event)
    expect(response).to have_http_status(:unauthorized)
  end

  it "rejects invalid token" do
    post upvote_event_path(event), headers: {
      "Authorization" => "Bearer invalid_token"
    }

    expect(response).to have_http_status(:unauthorized)
  end

  it "allows valid Clerk user" do
    allow(ClerkAuthenticator).to receive(:verify).and_return({
      "sub" => "user_123"
    })

    post upvote_event_path(event), headers: {
      "Authorization" => "Bearer valid_token"
    }

    expect(response).to have_http_status(:success)
  end
end