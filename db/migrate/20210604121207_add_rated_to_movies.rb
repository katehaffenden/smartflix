class AddRatedToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :rated, :string
  end
end
