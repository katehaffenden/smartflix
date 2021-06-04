class AddYearToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :year, :integer
  end
end
