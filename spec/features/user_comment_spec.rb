feature "user comment" do

  scenario "user can comment on another user" do
    log_in_william
    click_button "Log Out"

    log_in_damon
    visit user_url(User.find_by_username("william"))


    fill_in "Comment:", with: "william sux"
    click_button "Submit Comment"
    expect(page).to have_content("william sux")

  end

  scenario "comment can't be blank" do
    log_in_william
    click_button "Log Out"

    log_in_damon
    visit user_url(User.find_by_username("william"))

    click_button "Submit Comment"
    expect(page).to have_content("Body can't be blank")

  end



end
