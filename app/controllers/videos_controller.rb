
class VideosController < ApplicationController

  before_action :require_user

  def index
    @categories = Category.all
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:query])
  end
end
