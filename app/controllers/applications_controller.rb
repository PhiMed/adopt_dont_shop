class ApplicationsController < ActionController::Base
  def index
    @application = Application.all
  end

  def create
    @application = Application.create!(application_params)
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:id, :name, :street_address, :city, :zip_code, :reason)
  end
end
