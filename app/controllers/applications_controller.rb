class ApplicationsController < ActionController::Base
  def index
    @application = Application.all
  end

  def new
  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:id])
    @pets_applied_for = @application.pets
    @searched_pets = (
      if params[:search].present?
        Pet.search(params[:search])
      else
        []
      end)
  end

  private

  def application_params
    params.permit(:id, :name, :street_address, :city,
      :state, :zip_code, :reason, :application_status)
  end
end
