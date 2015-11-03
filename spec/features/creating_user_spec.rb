require 'rails_helper'

RSpec.feature "Creating users" do
  scenario "with valid credentials" do
    visit root_path

    click_link 'Sign up'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'
    fill_in 'Address', with: 'Suite 850'
    fill_in 'address_line2', with: '11 Avenue SW'
    fill_in 'City', with: 'Great City'
    fill_in 'Postal Code', with: '12345'
    click_button 'Create User'

    expect(page).to have_content('User has been created')
  end

  scenario "with invalid credentials" do
    visit root_path

    click_link 'Sign up'
    fill_in 'First name', with: ''
    fill_in 'Last name', with: ''
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'
    fill_in 'Address', with: 'Suite 850'
    fill_in 'address_line2', with: '11 Avenue SW'
    fill_in 'City', with: 'Great City'
    fill_in 'Postal Code', with: '12345'
    click_button 'Create User'

    expect(page).to have_content('User has not been created')
  end
end
