class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges
  has_many :projects

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

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

end
