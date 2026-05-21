class Votes::CastVote
  debugger
    def initialize(event:, user:, type:)
      @event = event
      @user = user
      @type = type
    end

  def call
    debugger
    build_event
  end

  private

  def build_event
    debugger
    {
      message: "Vote cast successfully",
      event_id: @event.id,
      user_id: @user["sub"]
    }
  end
end