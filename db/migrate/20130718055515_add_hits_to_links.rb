class AddHitsToLinks < ActiveRecord::Migration
  def change
    add_column :links, :hits, :integer, default: 0
  end
end
