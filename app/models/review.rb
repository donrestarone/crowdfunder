class Review < ApplicationRecord
  belongs_to :project
  belongs_to :user
  #has_one :user

  validates :content, presence: true, length: {minimum: 4}
end
