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

  test 'project_show_page_displays_amount_pledged_by_user' do

  end

end
