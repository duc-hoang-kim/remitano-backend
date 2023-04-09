class AddVideoYoutubeIdToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :youtube_id, :string
  end
end
