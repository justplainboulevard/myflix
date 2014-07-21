
class PagesController < ApplicationController

  def home
    @categories = Category.all
    @videos = Video.all
    render :home
  end
end
