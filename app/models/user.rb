class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges
  has_many :projects
  #reviews
  has_many :reviews
  # has_many :projects, through: :reviews

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def projects_backed
    return self.pledges
  end

  def name_of_projects_backed
    all_pledges = projects_backed
    projects = []
    all_pledges.each do |pledge|
      projects.push Project.find(pledge.project_id)
    end
    return projects
  end

  def amount_pledged_to_project(project)
    pledges.where(project_id:project.id).sum(:dollar_amount)

  end

end
