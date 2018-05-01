class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  
  validate :project_date_must_be_in_future
  validate :project_end_date_is_later_than_start_date
  validates :goal, numericality: {:only_integer => true, :greater_than => 0}
  validates :title, :description, :goal, :start_date, :end_date, presence: true
  validates :user, presence: true
  
  def project_end_date_is_later_than_start_date
    start_date = self.start_date
    if start_date > self.end_date
      errors.add(:end_date, "project end date must be later than start date")
    end
  end

  def project_date_must_be_in_future
  	present_time = Time.now 
  	if Time.now > self.start_date
  		errors.add(:start_date, 'project date must be in the future')
  	end 
  end 

end
