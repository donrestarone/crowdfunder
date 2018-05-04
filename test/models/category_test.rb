require_relative '../test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'test the association has_many projects' do
  category = build(:category)
  project = build(:project)
  category_project = category.projects
  assert(category.projects)
  end

end
