
class AddMissingIndexes < ActiveRecord::Migration

  def change

    add_index :invitations, :inviter_id
    add_index :payments, :user_id
    add_index :queue_items, :video_id
    add_index :queue_items, :user_id
    add_index :relationships, :leader_id
    add_index :relationships, :follower_id
    add_index :reviews, :user_id
    add_index :reviews, :video_id
    add_index :video_categories, :video_id
    add_index :video_categories, :category_id
  end
end
