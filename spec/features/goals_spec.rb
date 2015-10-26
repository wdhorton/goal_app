require 'rails_helper'
require 'spec_helper'

feature "goals" do

  feature "create goal" do
    scenario "user can create a goal" do
      log_in_william
      create_goal
      within("h1") do
        expect(page).to have_content("My New Goal")
      end
    end

    scenario "invalid goal returns error" do
      log_in_william
      visit '/goals'
      click_link "Create Goal"
      click_button "Create Goal"
      expect(page).to have_content("Description can't be blank")
    end
  end

  feature "edit goal" do
    scenario "user can edit a goal" do
      log_in_william
      create_goal

      click_link "Edit Goal"
      fill_in "Description", with: "Edited description"
      click_button "Edit Goal"
      within('h1') do
        expect(page).to have_content("Edited description")
      end
    end

    scenario "user can't edit other users' goals" do
      log_in_william
      create_goal
      click_button "Log Out"
      log_in_damon
      visit goal_url(User.find_by_username("william").goals.first)
      click_link "Edit Goal"

      expect(page).to have_content("Can't modify another user's goals")
    end

    scenario "invalid edit returns error" do
      log_in_william
      create_goal

      click_link "Edit Goal"
      fill_in "Description", with: ""
      click_button "Edit Goal"

      expect(page).to have_content("Description can't be blank")
    end
  end

  feature "delete goal" do

    scenario "user can delete a goal" do
      log_in_william
      create_goal

      click_button "Delete Goal"
      within('h1') do
        expect(page).to have_content("Goals")
      end
    end

    scenario "user can't delete other users' goals" do
      log_in_william
      create_goal
      click_button "Log Out"
      log_in_damon
      visit goal_url(User.find_by_username("william").goals.first)
      click_button "Delete Goal"

      expect(page).to have_content("Can't modify another user's goals")
    end
  end

  feature "goal privacy" do

    scenario "user can view their own private goals" do
      log_in_william
      create_private_goal

      expect(page).to have_content("My New Private Goal")
      visit '/goals'
      expect(page).to have_content("My New Private Goal")
    end

    scenario "user can't view other users' private goals" do
      log_in_william
      create_private_goal
      click_button "Log Out"

      log_in_damon

      visit goal_url(User.find_by_username("william").goals.first)
      expect(page).to have_content("Can't view another user's private goal")

      visit '/goals'
      expect(page).not_to have_content("My New Private Goal")
    end

    scenario "user can view other users' public goals" do
      log_in_william
      create_goal
      click_button "Log Out"

      log_in_damon

      visit goal_url(User.find_by_username("william").goals.first)
      expect(page).to have_content("My New Goal")

      visit '/goals'
      expect(page).to have_content("My New Goal")


    end

  end

  feature "goal completion" do

    scenario "users can see completion status" do
      log_in_william
      create_goal

      expect(page).to have_content("Completed: No")
    end

    scenario "user can mark goal complete" do
      log_in_william
      create_goal

      click_button "Completed"

      expect(page).to have_content("Completed: Yes")
    end

    scenario "user can't complete someone else's goal" do
      log_in_william
      create_goal
      click_button "Log Out"

      log_in_damon
      visit goal_url(User.find_by_username("william").goals.first)

      expect(page).to_not have_css('form#complete')

    end

  end

end
