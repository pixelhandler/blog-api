class AddAuthorRefToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :author, index: true, foreign_key: true
  end
end
