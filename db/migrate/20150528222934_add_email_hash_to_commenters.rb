class AddEmailHashToCommenters < ActiveRecord::Migration
  def change
    add_column :commenters, :email_hash, :string
  end
end
