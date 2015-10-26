require 'rails_helper'
require 'spec_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit 'users/new'
    within('h1') do
      expect(page).to have_content("Sign Up")
    end
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up("damon", "password")
      expect(page).to have_content("damon")
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    sign_up("william", "password")
    log_in("william", "password")
    expect(page).to have_content("william")
  end

end

feature "logging out" do

  scenario "begins with logged out state" do
    visit '/users'
    expect(page).to have_content("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_up("william", "password")
    log_in("william", "password")
    visit user_url(User.find_by_username("william"))
    click_button "Log Out"
    expect(page).not_to have_content("william")
  end

end
