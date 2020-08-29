class Request < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :reactions

  validates :title, :description, :user_id, presence: true
end
