class CreateCommenters < ActiveRecord::Migration
  def change
    create_table :commenters do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
    add_index :commenters, :email, unique: true
  end
end
