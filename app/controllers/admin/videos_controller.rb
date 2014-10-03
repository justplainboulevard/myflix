
class Admin::VideosController < ApplicationController

  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    binding.pry
    @video = Video.new(video_params)
    @video_categories = @video.video_categories.build(video_params[:category_ids])

    if @video.save && @video_categories.save
      flash[:success] = "You successfully added the video #{@video.title}!"
      redirect_to new_admin_video_path
    else
      flash[:danger] = 'You submitted invalid data. Please check each form field.'
      render :new
    end
  end

private

  def video_params
    params.require(:video).permit(:title, :description, :small_cover, :large_cover, category_ids: { category_ids: [] })
  end
end
