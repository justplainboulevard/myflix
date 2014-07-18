
class PagesController < ApplicationController

  def home
    @videos = Video.all
    render :home
  end
end
