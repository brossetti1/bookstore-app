require 'rails_helper'

RSpec.feature 'Showing user profile' do
  let!(:user) { Fabricate(:user, first_name: 'John', last_name: 'Doe',
                          email: 'john@example.com') }

  scenario do
    visit root_path

    click_link 'Users'
    print page.html
    click_link user.email

    within("h3.titles") do
      expect(page).to have_content('John Doe')
    end

    within("#first-name") do
      expect(page).to have_content('John')
    end

    within("#last-name") do
      expect(page).to have_content('Doe')
    end

    within("#email") do
      expect(page).to have_content('john@example.com')
    end
  end
end
