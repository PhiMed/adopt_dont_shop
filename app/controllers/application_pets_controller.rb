class ApplicationPetsController < ApplicationController

  def create
    application = Application.find(params[:id])
    already_there = false
    application.application_pets.each do |a|
      if "#{a.pet_id}" == params[:pet_id]
        already_there = true
      end
    end
    if already_there == false
      apppet = ApplicationPet.new({application_id: (params[:id]), pet_id: (params[:pet_id])})
      if apppet.save
        redirect_to "/applications/#{application.id}"
      end
    elsif already_there == true
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: You have alreay applied for this pet"
    end
  end

  def update
    application_pet = ApplicationPet.where(application_id: (params[:id]), pet_id: (params[:pet_id]))
    application_pet.each do |ap|
      ap.assign_attributes({:status => "#{params[:status]}"})
      ap.save
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
