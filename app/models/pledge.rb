class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  #project.user_id != pledge.user_id

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :validate_backer_is_not_owner
  validates :dollar_amount, :numericality => { :greater_than => 0 }

  def validate_backer_is_not_owner
    if project.user == user
      errors.add(:user_id, 'Owner cant back project')
    end
  end

  def self.sum_of_all_pledges_for_all_projects
    total = Pledge.all.sum(:dollar_amount)
    return  total
  end

  # def self.all_pledges
  #   all_pledges = Pledge.alld
  # end
end
