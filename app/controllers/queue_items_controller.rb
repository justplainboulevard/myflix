
class QueueItemsController < ApplicationController

  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    if already_queued?(@video)
      flash[:success] = "#{@video.title} is already in your queue."
      redirect_to my_queue_path
    else
      queue_video
      flash[:success] = "You added #{@video.title} to your queue."
      redirect_to my_queue_path
    end
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_list_order
    rescue ActiveRecord::RecordInvalid
      flash[:error] = 'You entered an invalid list order.'
    end
    redirect_to my_queue_path
  end

  def destroy
    @queue_item = QueueItem.find(params[:id])
    @video = @queue_item.video
    @queue_item.destroy if current_user.queue_items.include?(@queue_item)
    current_user.normalize_list_order
    flash[:warning] = "You removed #{@video.title} from your queue."
    redirect_to my_queue_path
  end

private

  def set_video

  end

  def queue_video
    QueueItem.create(video: @video, user: current_user, list_order: new_item_position)
  end

  def new_item_position
    current_user.queue_items.count + 1
  end

  def already_queued?(video)
    current_user.queue_items.map(&:video).include?(@video)
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |array_item|
        queue_item = QueueItem.find(array_item['id'])
        queue_item.update_attributes!(list_order: array_item['list_order']) if queue_item.user == current_user
      end
    end
  end
end
