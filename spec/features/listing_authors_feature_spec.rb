require 'rails_helper'

RSpec.feature 'Listing Authors' do
  let!(:john) { Fabricate(:author, first_name: 'John', last_name: 'Doe') }
  let!(:mary) { Fabricate(:author, first_name: 'Mary', last_name: 'Grant') }

  scenario 'in the database' do
    visit root_path

    click_link 'Authors'

    within('.page-header') do
      expect(page).to have_content('All Authors')
    end

    within('#new-author-link') do
      expect(page).to have_link('Add New author')
    end

    within('#authors-list') do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Mary Grant')
    end
  end

  scenario 'with none created' do
    Author.delete_all

    visit root_path

    click_link 'Authors'

    expect(Author.count).to eq(0)

    within('.page-header') do
      expect(page).to have_content('No Authors Created')
    end

    within('#new-author-link') do
      expect(page).to have_link('Add New author')
    end
  end
end
