require 'rails_helper'

RSpec.feature "Creating Authors" do
  let(:admin) { Fabricate(:admin) }

  before { sign_in_as admin }

  scenario "with valid inputs succeeds" do
    visit root_path

    click_link "Authors"
    click_link "Add New author"

    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"

    click_button "Create Author"

    expect(page).to have_content("Author has been created")
  end

  scenario "with an invalid input fails" do
    visit root_path

    click_link "Authors"
    click_link "Add New author"

    fill_in "First name", with: ""
    fill_in "Last name", with: ""

    click_button "Create Author"

    expect(page).to have_content("Author has not been created")
  end
end
