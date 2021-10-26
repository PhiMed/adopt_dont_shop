class AdminSheltersController < ApplicationController
  def index
      @adminshelters = Shelter.reverse_alpha_order
  end
end
