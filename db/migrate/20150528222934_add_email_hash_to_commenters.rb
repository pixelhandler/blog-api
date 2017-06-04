class AddEmailHashToCommenters < ActiveRecord::Migration[5.1]
  def change
    add_column :commenters, :email_hash, :string
  end
end
