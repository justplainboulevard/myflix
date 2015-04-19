
class CreateVideos < ActiveRecord::Migration

  def change

    create_table :videos do |t|

      t.string :title
      t.text :description
      t.string :poster_small_url
      t.string :poster_large_url

      t.timestamps
    end
  end
end
