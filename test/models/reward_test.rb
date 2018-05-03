require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  def create_project
    project = new_project
    project.save
    project
  end

  def build_reward
    reward = build(:reward, project: create_project)
  end

  test 'A reward can be created' do
    reward = build_reward
    reward.save
    assert reward.valid?
    assert reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do

    reward = build(:reward,
      description: 'A heartfelt thanks!',
      project: create_project, dollar_amount: nil
    )
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    reward = build(:reward,
      dollar_amount: 99.00,
      project: create_project,
      description: nil
    )
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  test 'Reward dollar_amount must be positive number' do
    reward = build(:reward,
      dollar_amount: -1,
      project: create_project
    )
    assert reward.invalid?
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

end
