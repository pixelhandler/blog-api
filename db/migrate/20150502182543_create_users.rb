class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.references :author, foreign_key: true

      t.timestamps null: false
    end
  end
end