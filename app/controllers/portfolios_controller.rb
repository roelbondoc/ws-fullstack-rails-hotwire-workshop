class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.order(:name).page(params[:page]).per(25).includes(allocations: { asset_class: :securities })
    @portfolios = @portfolios.search_by_name(params[:q]) if params[:q].present?
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end
end
