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

<<<<<<< HEAD
  test "display full name method" do
    user = build(:user, first_name: 'Mickey', last_name: 'Mouse')
    assert_equal('Mickey Mouse', user.full_name)
=======

  test 'projects_backed_returns_empty' do
    user = build(:user)
    assert_empty user.projects_backed
  end

  test 'projects_backed_returns_1' do
    user = make_pledge_to_project
    assert_equal(1, user.projects_backed.count)

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

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today + 1.day,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
>>>>>>> 196c1f9c4ae0ed2b7a9a49a7a09e8c7e04b7db1b
  end

end
