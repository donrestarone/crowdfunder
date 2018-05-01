class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validate :project_date_must_be_in_future
  validates :title, :description, :goal, :start_date, :end_date, presence: true
  validates :user, presence: true

  def project_date_must_be_in_future
  	present_time = Time.now 
  	if Time.now > self.start_date
  		errors.add(:start_date, 'project date must be in the future')
  	end 
  end 
end
