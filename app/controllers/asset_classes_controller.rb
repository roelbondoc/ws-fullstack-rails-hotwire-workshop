class AssetClassesController < ApplicationController
  def show
    @asset_class = AssetClass.find(params[:id])
  end
end
