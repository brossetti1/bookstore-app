require 'rails_helper'
require 'support/macros'

RSpec.feature 'Creating Publishers' do
  let(:admin) { Fabricate(:admin) }

  before do
    sign_in_as admin
  end

  scenario 'create a valid publisher' do
    visit root_path
    click_link 'Publishers'
    click_link 'Add New publisher'

    fill_in 'Name', with: 'John Bull'
    click_button 'Create Publisher'

    expect(page).to have_content('Publisher has been created.')
  end

  scenario 'creating publisher with invalid fields fails' do
    visit root_path
    click_link 'Publishers'
    click_link 'Add New publisher'

    fill_in 'Name', with: ''
    click_button 'Create Publisher'

    expect(page).to have_content('Publisher has not been created.')
  end
end
