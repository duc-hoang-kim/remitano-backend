class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :youtube_url, null: false
      t.integer :shared_by, null: false
      t.integer :upvote_count, default: 0
      t.integer :downvote_count, default: 0
      t.string :description
      t.string :title, null: false

      t.timestamps
    end
  end
end
