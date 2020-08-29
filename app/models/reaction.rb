class Reaction < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum kind: [:like, :dislike]

  validates :kind, :user_id, :request_id, presence: true
end
