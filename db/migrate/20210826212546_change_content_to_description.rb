class ChangeContentToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :content, :description
  end
end
