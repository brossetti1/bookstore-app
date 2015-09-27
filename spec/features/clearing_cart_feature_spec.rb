require 'rails_helper'

RSpec.feature "Deleting Carts" do
  let!(:railsWay) { Fabricate(:book, title: 'The Rails 4 Way') }

  scenario "clear contents of  cart" do
    visit "/"

    expect(page).to have_link(railsWay.title)

    click_link railsWay.title
    click_button "Add to cart"
    expect(page).to have_button("Clear cart")

    click_button "Clear cart"

    expect(current_path).to eq(catalogs_path)
  end
end
