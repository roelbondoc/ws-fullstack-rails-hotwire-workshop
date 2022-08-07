class SearchController < ApplicationController
  def results
    @records = PgSearch.multisearch(params[:q]).page(params[:page]).per(5)
  end
end
