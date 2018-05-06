require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
    user = create(:user)
    user2 = build(:user, password: "00000000", password_confirmation: "00000000")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = build(:user, password_confirmation: nil)
    refute user.valid?
  end

  test "password must match confirmation" do
    user = build(:user, password_confirmation: "87654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = build(:user, email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234")
    refute user.valid?
  end


  test 'projects_backed_returns_empty' do
    user = build(:user)
    assert_empty user.projects_backed
  end

  test 'projects_backed_returns_1' do
    user = make_pledge_to_project
    assert_equal(1, user.projects_backed.count)

  end

  test 'amount_pledged_to_project_returns_false' do
    project = create(:project)
    user = create(:user, first_name: 'Sally')
    user1 = create(:user, first_name: 'Ally')
    user2 = create(:user, first_name: 'Lly')
    pledge = create(:pledge, project: project, user: user2)
    assert_equal(0, user1.amount_pledged_to_project(project))
  end

  test 'amount_pledged_to_project_returns_10' do
    project = create(:project)
    user = create(:user, first_name: 'Sally')
    pledge = create(:pledge, project: project, user: user)

    assert_equal(10, user.amount_pledged_to_project(project))
  end

  test 'full_name_returns_true' do
    pledger = make_pledge_to_project
    assert(pledger.full_name)
  end

  test 'full_name_matches_expectation' do
    pledger = make_pledge_to_project
    assert_equal('Bobbert Lastname', pledger.full_name)
  end

  test 'name_of_projects_backed_returns_true' do
    pledger = make_pledge_to_project
    assert(pledger.name_of_projects_backed)
  end

  def make_pledge_to_project
    project = new_project
    owner = create(:user, first_name: "Cletus")
    project.user = owner
    project.save

    pledger = create(:user, first_name: "Bobbert")
    a_pledge = Pledge.create(dollar_amount: 12, user: pledger, project_id: project.id)
    return pledger
  end

  def make_pledge_to_project_and_return_project
    project = new_project
    owner = create(:user, first_name: "Cletus")
    project.user = owner
    project.save

    pledger = create(:user, first_name: "Bobbert")
    a_pledge = Pledge.create(dollar_amount: 12, user: pledger, project_id: project.id)
    return project
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
