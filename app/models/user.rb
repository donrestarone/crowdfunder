class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges
  has_many :projects
  has_many :rewards, through: :pledges

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

  # def rewards_claimed_for_project(project)
  #   rewards.where(project_id:project.id)
  # end

  def amount_pledged_to_project(project)
    pledges.where(project_id:project.id).sum(:dollar_amount)
  end


end
