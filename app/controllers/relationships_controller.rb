
class RelationshipsController < ApplicationController

  before_action :require_user

  def index
    @relationships = current_user.follower_relationships
  end

  def create
    leader = User.find(params[:leader_id])
    if current_user.can_follow?(leader)
      relationship = Relationship.create(leader_id: params[:leader_id], follower_id: current_user.id)
      flash[:success] = "You are now following #{relationship.leader.full_name}!"
    elsif current_user == leader
      flash[:success] = "You cannot follow yourself!"
    else
      flash[:success] = "You already follow #{leader.full_name}!"
    end
    redirect_to people_path
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy if @relationship.follower_id == current_user.id
    flash[:warning] = "You are no longer following #{@relationship.leader.full_name}."
    redirect_to people_path
  end

private

  def follow_user
    Relationship.create(follower_id: current_user.id, leader_id: params[:leader_id])
  end
end
