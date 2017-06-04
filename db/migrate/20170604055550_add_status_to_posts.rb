class AddStatusToPosts < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :status, :string, default: 'pending'

    execute <<-SQL
      UPDATE posts SET status = 'published'
    SQL
  end

  def down
    remove_column :posts, :status
  end
end
