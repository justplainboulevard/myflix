
class RenameColumnsInVideos < ActiveRecord::Migration

  def change
    rename_column :videos, :poster_small_url, :small_cover
    rename_column :videos, :poster_large_url, :large_cover
  end
end
