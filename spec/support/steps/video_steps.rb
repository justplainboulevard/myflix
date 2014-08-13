
include CommonSteps

module VideoSteps

  def find_video(video)
    ensure_on(home_path)
    find('img', text: video.poster_small_url)
  end
end