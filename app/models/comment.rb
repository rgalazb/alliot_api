class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request

  validates :content, :user_id, :request_id, presence: true
end
