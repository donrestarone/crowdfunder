class Reward < ActiveRecord::Base

  # Reward dollar_amount must be positive number
  validates :dollar_amount, :numericality => { :greater_than => 0 }, presence: true
  validates :description, presence: true
  validates :dollar_amount, presence: true

  belongs_to :project

  # def assign_reward
  #   if
  #
  #   end
  # end


end
