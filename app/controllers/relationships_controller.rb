
class RelationshipsController < ApplicationController

  before_action :require_user

  def index
    @relationships = current_user.follower_relationships
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy if @relationship.follower_id == current_user.id
    flash[:warning] = "You are no longer following #{@relationship.leader.full_name}."
    redirect_to people_path
  end
end
