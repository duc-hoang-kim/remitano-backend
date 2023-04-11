class RenameColumnSharedBy < ActiveRecord::Migration[7.0]
  def change
    rename_column :videos, :shared_by, :sharer_id
  end
end
