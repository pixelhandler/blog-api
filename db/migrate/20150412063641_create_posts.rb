class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :body
      t.string :excerpt
      t.string :slug
      t.string :title
      t.date :date

      t.timestamps null: false
    end
  end
end
