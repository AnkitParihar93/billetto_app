class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :event
 
  scope :upvotes, -> { where(vote_type: 1) }
  scope :downvotes, -> { where(vote_type: -1) }
  validates :user_id, uniqueness: { scope: :event_id }
end