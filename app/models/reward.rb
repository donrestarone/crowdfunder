class Reward < ActiveRecord::Base
  # Reward dollar_amount must be positive number
  validates :description, presence: true
  validates :dollar_amount, presence: true
  belongs_to :project



end
