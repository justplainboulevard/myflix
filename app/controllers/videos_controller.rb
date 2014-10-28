
class VideosController < ApplicationController

  before_action :require_user

  decorates_assigned :video

  def index
    @categories = Category.all
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params[:query])
  end
end
