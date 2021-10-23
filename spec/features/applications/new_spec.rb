require 'rails_helper'

RSpec.describe 'application new page' do

  it 'displays an application form' do
    visit "/applications/new"

    expect(page).to have_content("Name")
    expect(page).to have_button("Submit")
  end

  it 'can create a new application and show it' do
    visit "/applications/new"

    fill_in('Name', with: 'Caroline Russotti')
    fill_in('Street address', with: '70 Applegate Dr.')
    fill_in('City', with: 'Franklin Square')
    fill_in('State', with: 'NY')
    fill_in('Zip code', with: '11011')

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Caroline")
  end
end
