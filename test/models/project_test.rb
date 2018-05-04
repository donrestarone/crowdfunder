require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do

    project = build(:project)

    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do

    project = build(:project)

    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  test 'project_end_date_is_later_than_start_date' do

    project = build(:project, title:'Cool new boardgame', description: 'Trade sheep', start_date:  Date.today, end_date:  Date.today - 1.month, goal:50000)

    project.save
    assert project.invalid?, "project should not save if end date is earlier
    than start date"
  end

  test 'project_invalid_if_goal_negative' do

    project = build(:project, title:'Cool new boardgame', description: 'Trade sheep', start_date:  Date.today, end_date:  Date.today + 1.month, goal:-1)

    project.save
    assert project.invalid?, "project should not save if goal is negative"
  end

  test 'project_date_must_be_in_future' do
    project = build(:project, title:'Cool board', description: 'Trade stuff', start_date: Date.today, end_date:    Date.today - 1.month,goal:50000)

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

  test 'how_many_projects_funded_does_not_count_duplicates' do
    make_multiple_people_pledge_a_project
    project = new_project
    owner = new_user
    project.user = owner
    project.save
    assert_equal(1, Project.how_many_projects_funded.count)
  end

  test 'number_of_all_projects_returns_one' do
    make_multiple_people_pledge_a_project
    assert_equal(1, Project.number_of_all_projects)
  end

  test 'project_funding_returns_24' do
    project = make_multiple_people_pledge_a_project
    assert_equal(24, project.project_funding(project.id))
  end

  test 'projects_waiting_to_be_funded_returns_1' do
    make_pledge_to_project
    #make_multiple_people_pledge_a_project
    project = new_project
    owner = create(:user, first_name: "Bobby")
    project.user = owner
    project.save
    assert_equal(1, Project.projects_waiting_to_be_funded)
  end

  test 'owner_of_project_returns_true' do
    a_project = make_multiple_people_pledge_a_project
    assert(a_project.owner_of_project)
  end

  test 'owner_of_project_returns_one' do
    a_project = make_multiple_people_pledge_a_project
    owner = a_project.owner_of_project

    assert_equal("Cletus", owner.first_name)
  end

  test 'projects_of_owner_returns_true' do
    a_project = make_multiple_people_pledge_a_project
    assert(a_project.projects_of_owner)
  end

  test 'projects_of_owner_returns_one' do
    a_project = make_multiple_people_pledge_a_project
    assert_equal(1, a_project.projects_of_owner.count)
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

    pledger = create(:user, first_name: "Bobbert")
    a_pledge = Pledge.create(dollar_amount: 12, user: pledger, project_id: project.id)
    return project
  end

  def make_multiple_people_pledge_a_project
    project = new_project
    owner = create(:user, first_name: "Cletus")
    project.user = owner
    project.save

    pledger1 = create(:user, first_name: "Bob")
    pledger2 = create(:user, first_name: "Bobby")
    a_pledge = Pledge.create(dollar_amount: 12, user: pledger1, project_id: project.id)
    another_pledge = Pledge.create(dollar_amount: 12, user: pledger2, project_id: project.id)
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
