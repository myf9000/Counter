class AddSlugToCounts < ActiveRecord::Migration
  def change
    add_column :counts, :slug, :string
    add_index :counts, :slug, unique: true
  end
end
