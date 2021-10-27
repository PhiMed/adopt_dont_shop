class ApplicationsController < ActionController::Base
  def index
    @application = Application.all
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: You must complete all fields"
    end
  end

  def show
    @application = Application.find(params[:id])
    @searched_pets = (
      if params[:search].present?
        Pet.search(params[:search])
      else
        []
      end)
  end

  def update
    application = Application.find_by_id("#{(params[:id])}")
    if params[:reason].empty?
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: You must provide a reason"
    else
    application.assign_attributes({:reason => params[:reason]})
    application.update_attributes({:application_status => "Pending"})
    redirect_to "/applications/#{application.id}"
    end
  end

  private

  def application_params
    params.permit(:id, :name, :street_address, :city,
      :state, :zip_code, :reason, :application_status)
  end
end
