class Reaction < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum kind: [:like, :dislike]
end
