
class PagesController < ApplicationController

  def front
    redirect to home_path if signed_in?
  end
end
