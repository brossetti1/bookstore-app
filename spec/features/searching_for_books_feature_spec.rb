require 'rails_helper'

RSpec.feature "Searching for Books" do
  let!(:iText) { Fabricate(:book, title: 'iText in Action') }
  let!(:railsWay) { Fabricate(:book, title: 'The Rails 4 Way') }

  scenario "with existing title returns all those books" do
    visit "/"

    fill_in "search_word", with: "Action"
    click_button "Search"

    expect(page).to have_link(iText.title)
    expect(page).not_to have_content(railsWay.title)
    expect(current_path).to eq(search_catalogs_path)
  end

end
