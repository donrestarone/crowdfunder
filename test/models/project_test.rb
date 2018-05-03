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

end
