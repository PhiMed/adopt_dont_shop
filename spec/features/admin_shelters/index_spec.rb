require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  it 'lists all the admin shelter names' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'Bravo animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Charlies pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit "admin/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
  end

  it 'lists the shelters by most recently created first' do
    a = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    c = Shelter.create(name: 'Charlies pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    b = Shelter.create(name: 'Bravo animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)


    visit "admin/shelters"
  
    expect(c.name).to appear_before(b.name)
    expect(b.name).to appear_before(a.name)
  end

  end
