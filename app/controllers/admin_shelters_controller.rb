class AdminSheltersController < ApplicationController
  def index
      @adminshelters = Shelter.reverse_alpha_order
      @pendingshelters = Shelter.shelters_with_pending_app
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

end
