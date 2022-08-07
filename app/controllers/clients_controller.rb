class ClientsController < ApplicationController
  def index
    @clients = Client.order(:name).page(params[:page]).per(25)
    @clients = @clients.search_by_all(params[:q]) if params[:q].present?
    @clients = @clients.where(city: params[:city]) if params[:city].present?
    @clients = @clients.where(country: params[:country]) if params[:country].present?
  end

  def show
    @client = Client.find(params[:id])
  end
end
