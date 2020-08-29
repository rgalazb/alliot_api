class Request < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :reactions
end
