require 'rails_helper'
require 'spec_helper'

feature "goals" do
  scenario "user can create a goal" do
    visit '/goals'
    click_button "Create Goal"
    fill_in "Description", "My New Goal"
    click_button "Submit"

    expect(page).to have_content("My New Goal")

  end
end
