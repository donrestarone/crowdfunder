class Reward < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :project
end
