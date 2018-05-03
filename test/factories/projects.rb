FactoryGirl.define do
  factory :project do
      title      'Cool new boardgame'
      description 'Trade sheep'
      start_date  Date.today + 1.day
      end_date    Date.today + 1.month
      goal        50000
      user #uses the user factory automaticaly

  end
end
