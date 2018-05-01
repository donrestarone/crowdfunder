class Reward < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :project

  validates :dollar_amount, presence: true

end
