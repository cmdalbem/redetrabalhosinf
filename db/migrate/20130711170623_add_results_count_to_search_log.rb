class AddResultsCountToSearchLog < ActiveRecord::Migration
  def change
    add_column :search_logs, :resultsCount, :integer
  end
end
