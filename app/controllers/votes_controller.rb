class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  skip_before_action :verify_authenticity_token, only: [:upvote, :downvote]

  def upvote
    vote = Vote.find_by(user: current_user, event: @event)

    if vote&.vote_type == 1
      vote.destroy
    else
      vote ||= Vote.new(user: current_user, event: @event)
      vote.vote_type = 1
      vote.save!
    end
    render json: vote_data
  end

  def downvote
    vote = Vote.find_by(user: current_user, event: @event)
    if vote&.vote_type == -1
      vote.destroy
    else
      vote ||= Vote.new(user: current_user, event: @event)
      vote.vote_type = -1
      vote.save!
    end
    render json: vote_data
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def vote_data
    {
      upvotes: @event.votes.where(vote_type: 1).count,
      downvotes: @event.votes.where(vote_type: -1).count
    }
  end
end