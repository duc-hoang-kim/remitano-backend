class VideoSerializer < ActiveModel::Serializer
  attributes :youtube_url, :downvote_count, :upvote_count, :description,
             :title, :created_at, :sharer_email, :youtube_id, :id

  def sharer_email
    object.sharer&.email
  end
end
