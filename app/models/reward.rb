class Reward < ActiveRecord::Base
  has_many :users, through: :pledges
  # Reward dollar_amount must be positive number
  validates :dollar_amount, :numericality => { :greater_than => 0 }, presence: true
  validates :description, presence: true
  validates :dollar_amount, presence: true

  belongs_to :project

  # def assign_reward
  #   if
  #
  #   endsd
  # end


end
