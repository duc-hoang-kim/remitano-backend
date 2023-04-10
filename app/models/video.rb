class Video < ApplicationRecord
  belongs_to :sharer, class_name: "User", foreign_key: "shared_by"
end
