require 'rails_helper'

RSpec.feature "Creating Authors" do
  scenario "with valid inputs succeeds" do
    visit root_path

    click_link "Authors"
    click_link "Add New author"

    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"

    click_button "Create Author"

    expect(page).to have_content("Author has been created")
  end
end
