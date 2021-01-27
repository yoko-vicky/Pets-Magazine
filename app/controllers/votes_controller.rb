class VotesController < ApplicationController
  before_action :require_login

  def create
    Vote.create(user_id: current_user.id, article_id: params[:article_id])
    redirect_back fallback_location: root_path
  end

  def destroy
    vote = Vote.where(user_id: current_user.id, article_id: params[:article_id]).first
    vote.destroy
    redirect_back fallback_location: root_path
  end
end
