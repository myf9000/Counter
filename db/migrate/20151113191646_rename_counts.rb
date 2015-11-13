class RenameCounts < ActiveRecord::Migration
  def change
  	rename_table :counts, :sentences
  end
end
