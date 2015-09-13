require 'rails_helper'
require 'support/macros'

RSpec.feature "Hiding Users link" do
  let(:user) { Fabricate(:user) }

  scenario "access to non-admin users not allowed" do
    sign_in_as user

    visit root_path
    expect(page).not_to have_link("Users")
  end
end
