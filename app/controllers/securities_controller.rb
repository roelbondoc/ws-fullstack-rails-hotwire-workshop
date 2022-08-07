class SecuritiesController < ApplicationController
  def index
    @securities = Security.order(:symbol).page(params[:page]).per(10)
    @securities = @securities.search_by_symbol(params[:q]) if params[:q].present?
  end

  def show
    @security = Security.find(params[:id])
  end
end
