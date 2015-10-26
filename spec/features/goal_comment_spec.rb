feature "goal comment" do

  scenario "user can comment on a goal" do
    log_in_william
    create_goal
    click_button "Log Out"

    log_in_damon
    visit goal_url(Goal.first)


    fill_in "Comment:", with: "william's goal sux"
    click_button "Submit Comment"
    expect(page).to have_content("william's goal sux")

  end

  scenario "comment can't be blank" do
    log_in_william
    create_goal
    click_button "Log Out"

    log_in_damon
    visit goal_url(Goal.first)

    click_button "Submit Comment"
    expect(page).to have_content("Body can't be blank")

  end



end
