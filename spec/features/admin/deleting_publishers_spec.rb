require 'rails_helper'
require 'support/macros'

RSpec.feature 'Deleting Publishers' do
  let(:admin) { Fabricate(:admin) }

  before do
    sign_in_as admin
  end

  scenario 'deleting an publisher' do
    publisher = Fabricate(:publisher)
    visit root_path
    click_link 'Publishers'
    click_link publisher.name
    click_link 'Delete'

    expect(page).to have_content('Publisher has been deleted.')
    expect(page.current_path).to eq(admin_publishers_path)
  end
end
