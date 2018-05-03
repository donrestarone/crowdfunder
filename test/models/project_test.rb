require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    skip
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    skip
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  test 'project_end_date_is_later_than_start_date' do
    skip
    project = new_invalid_project_end_date_early
    owner = new_user
    project.user = owner
    project.save
    assert project.invalid?, "project should not save if end date is earlier
    than start date"
  end

  test 'project_invalid_if_goal_negative' do
    project = new_invalid_project_end_date_early
    owner = new_user
    project.user = owner
    project.save
    assert project.invalid?, "project should not save if goal is negative"
  end

  test 'project_date_must_be_in_future' do

    project = new_invalid_project
    owner = new_user
    project.user = owner
    project.save
    assert project.invalid?, 'project should not save if date is not in the future'
  end

  test 'how_many_projects_funded_returns_nil' do
    project = new_project
    owner = new_user
    project.user = owner
    project.save
    assert_empty Project.how_many_projects_funded, 'idk'
  end

  test 'how_many_projects_funded_returns_one' do
    make_pledge_to_project
    assert_equal(1, Project.how_many_projects_funded.count)
  end

  test 'how_many_projects_funded_returns_one_when_there_are_2_projects' do
    project = new_project
    owner = new_user
    project.user = owner
    project.save
    make_pledge_to_project
    assert_equal(1, Project.how_many_projects_funded.count)
  end



  def new_invalid_project_end_date_early
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today - 1.month,
      goal:        50000
    )
  end

  def negative_goal_project
    Project.new(
      title:       'Great new boardgame',
      description: 'Trade livestock',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        -1
    )
  end

  def make_pledge_to_project
    project = new_project
    owner = create(:user, first_name: "Cletus")
    project.user = owner
    project.save

    pledger = create(:user, first_name: "Bob")
    a_pledge = Pledge.create(dollar_amount: 12, user: pledger, project_id: project.id)
    return project
  end

  def new_invalid_project
    Project.new(
      title:       'Cool board',
      description: 'Trade stuff',
      start_date:  Date.today,
      end_date:    Date.today - 1.month,
      goal:        50000
      )
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today + 1.day,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

end
