
class ReviewsController < ApplicationController

  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user_id: current_user.id))

    if @review.save
      flash[:success] = 'Your review has been posted. Thanks!'
      redirect_to video_path(@video)
    else
      render 'videos/show'
    end
  end

private

  def review_params
    params.require(:review).permit(:body, :rating, :user_id, :video_id)
  end
end
