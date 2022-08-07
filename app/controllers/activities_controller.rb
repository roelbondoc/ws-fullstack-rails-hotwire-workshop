class ActivitiesController < ApplicationController
  def index
    @activities = Activity.order(posted_at: :desc).includes(:account, :security).page(params[:page]).per(50)
    @activities = @activities.where(accounts: { client_id: params[:client_id] }).joins(:account) if params[:client_id].present?
    @activities = @activities.where(account_id: params[:account_id]) if params[:account_id].present?
    @activities = @activities.where(security_id: params[:security_id]) if params[:security_id].present?
    @activities = @activities.where(activity_type: params[:activity_type]) if params[:activity_type].present?
  end
end
