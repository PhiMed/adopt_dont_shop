require 'rails_helper'

RSpec.describe 'admin application show page' do
  it 'displays the applied for pets' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    app_1 = Application.create(name: 'Adam', street_address: '21',
       city: 'Mexico DF', state: 'DF', zip_code: 12, application_status: 'Pending')
    app_pet_1 = ApplicationPet.create(pet_id: pet_1.id, application_id: app_1.id)

    visit "/admin/applications/#{app_1.id}"

    expect(page).to have_content("Hayden")

  end

  it 'can approve or reject a single pet' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    app_1 = Application.create(name: 'Adam', street_address: '21',
       city: 'Mexico DF', state: 'DF', zip_code: 12, application_status: 'Pending')
    app_pet_1 = ApplicationPet.create(pet_id: pet_1.id, application_id: app_1.id)

    visit "/admin/applications/#{app_1.id}"

    expect(page).not_to have_content("Approved")

    click_button('Approve this pet application')

    expect(page).to have_content("Approved")
    expect(page).not_to have_content("Approve this pet application")

    click_button('Deny this pet application')

    expect(page).to have_content("Rejected")
    expect(page).not_to have_content("Deny this pet application")





  end


end
