class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  #reviews
  has_many :reviews
  # has_many :users, through: :reviews, as: :userReviews

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

  def owner_of_project
    if self.user_id
      owner = self.user_id
    end
    owner_name = User.find(owner)
  end

  def projects_of_owner
    all_projects = Project.all
    owner = self.user_id
    projects = []
    all_projects.each do |project|
      if project.user_id == self.user_id
        projects.push project
      end
    end
    return projects
  end

  def project_date_must_be_in_future
  	present_time = Time.now
  	if Time.now > self.start_date
  		errors.add(:start_date, 'project date must be in the future')
  	end
  end

  def project_funding(project_id)
    project = Project.find(project_id)
    funding_thus_far = project.pledges.sum(:dollar_amount)
    return funding_thus_far
  end

  def self.number_of_all_projects
    total = Project.all.count
    return total
  end

  def self.how_many_projects_funded
    all_projects = Project.all
    funded_projects = []
    all_projects.each do |project|
      project.pledges.each do |pledge|
        if pledge
          funded_projects.push project
        end
      end
    end
    return funded_projects.uniq
  end

  def self.projects_waiting_to_be_funded
    funded_projects = Project.how_many_projects_funded.count
    total_projects = Project.all.count
    delta = total_projects - funded_projects

    return delta
  end
end
