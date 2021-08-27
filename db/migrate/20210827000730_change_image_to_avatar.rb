class ChangeImageToAvatar < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :image, :avatar
  end
end
