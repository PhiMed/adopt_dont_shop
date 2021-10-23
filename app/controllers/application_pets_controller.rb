class ApplicationPetsController < ApplicationController
  def index
    @application = Application.find(params[:application_id])
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @application = Application.find_by_id("#{(params[:application_id])}")
    @pet = Pet.find_by_id("#{(params[:pet_id])}")
    ApplicationPet.create!({application_id: "#{@application.id}", pet_id: "#{@pet.id}"})
    redirect_to "/applications/#{@application.id}"
  end
end
