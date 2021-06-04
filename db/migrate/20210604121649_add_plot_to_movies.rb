class AddPlotToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :plot, :text
  end
end
