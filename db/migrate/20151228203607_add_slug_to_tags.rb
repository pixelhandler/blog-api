class AddSlugToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :slug, :string
  end
end
