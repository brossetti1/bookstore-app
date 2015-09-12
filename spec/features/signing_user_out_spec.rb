require 'rails_helper'
require 'support/macros'

RSpec.feature "Signing Users Out" do
  let(:user) { Fabricate(:user) }

  before { sign_in_as user }

  scenario do
    visit root_path

    click_link "Sign out"

    expect(page).to have_content("You have been signed out")
    expect(current_path).to eq(root_path)
    expect(page).not_to have_content("Sign out")
  end
end
