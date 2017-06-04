class AddTenant < ActiveRecord::Migration[5.1]
  def up
    add_column :authors, :tenant, :string, default: 'pixelhandler'
    add_column :comments, :tenant, :string, default: 'pixelhandler'
    add_column :commenters, :tenant, :string, default: 'pixelhandler'
    add_column :posts, :tenant, :string, default: 'pixelhandler'
    add_column :tags, :tenant, :string, default: 'pixelhandler'
    add_column :users, :tenant, :string, default: 'pixelhandler'

    execute <<-SQL
      UPDATE authors SET tenant = 'pixelhandler';
      UPDATE comments SET tenant = 'pixelhandler';
      UPDATE commenters SET tenant = 'pixelhandler';
      UPDATE posts SET tenant = 'pixelhandler';
      UPDATE tags SET tenant = 'pixelhandler';
      UPDATE users SET tenant = 'pixelhandler';
    SQL
  end

  def down
    remove_column :authors, :tenant
    remove_column :comments, :tenant
    remove_column :commenters, :tenant
    remove_column :posts, :tenant
    remove_column :tags, :tenant
    remove_column :users, :tenant
  end
end
