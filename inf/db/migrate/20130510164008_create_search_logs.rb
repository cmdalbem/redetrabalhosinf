class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.text :text

      t.timestamps
    end
  end
end
