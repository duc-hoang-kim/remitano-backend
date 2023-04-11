class Video < ApplicationRecord
  belongs_to :sharer, class_name: "User", foreign_key: "sharer_id"
end
