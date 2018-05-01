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

end
