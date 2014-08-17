
class RelationshipsController < ApplicationController

  before_action :require_user

  def index
    @relationships = current_user.follower_relationships
  end
end
