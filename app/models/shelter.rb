class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.reverse_alpha_order
    find_by_sql("SELECT  shelters.* FROM shelters
       ORDER BY shelters.name DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def self.shelters_with_pending_app
    applications = Application.where(application_status: 'Pending').joins(:application_pets)
    shelters = []
    container = []
    applications.each do |a|
      a.pets.each do |p|
        shelters << p.shelter_id
      end
    end
    shelters.each do |s|
      container << (Shelter.find_by id: s)
    end
    container
  end

  def average_age
    adoptable_pets.average(:age)
  end

  def adoptable_pet_count
    adoptable_pets.count
  end
end
