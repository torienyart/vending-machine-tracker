require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end
  
  it 'they see the names and prices of snacks in the machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    
    mms = dons.snacks.create(name: "M&Ms", price: 1.00)
    snickers = dons.snacks.create(name: "Snickers", price: 1.50)
    grapefruit = dons.snacks.create(name: "Grapefruit", price: 2.00)
    sardines = dons.snacks.create(name: "Sardines", price: 3.00)

    visit machine_path(dons)
    
    within "#snacks" do
      expect(page).to have_content(mms.name)
      expect(page).to have_content(mms.price)
      expect(page).to have_content(snickers.name)
      expect(page).to have_content(snickers.price)
      expect(page).to have_content(grapefruit.name)
      expect(page).to have_content(grapefruit.price)
      expect(page).to have_content(sardines.name)
      expect(page).to have_content(sardines.price)
    end
  end
end
