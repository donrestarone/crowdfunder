require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do

    pledge = build(:pledge, user: new_user, project: new_project)
    pledge.save
    assert pledge.valid?
    assert pledge.persisted?
  end

  test 'owner cannot back own project' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledge = build(:pledge, project: project)
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  test 'sum_of_all_pledges_for_all_projects_returns_20' do
    pledge = build(:pledge, user: new_user, project: new_project)
    pledge.save
    pledge2 = build(:pledge, user: new_user, project: new_project)
    pledge2.save
    assert_equal(20, Pledge.sum_of_all_pledges_for_all_projects)

  end


  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
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
