class Event < ApplicationRecord
  validates :external_id, presence: true, uniqueness: true
  validates :title, presence: true
  has_one_attached :image
  has_many :votes, dependent: :destroy
  has_many :users, through: :vote
  
  def upvotes
    votes.where(vote_type: 1).count
  end

  def downvotes
    votes.where(vote_type: -1).count
  end
end