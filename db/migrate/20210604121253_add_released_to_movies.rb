class AddReleasedToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :released, :datetime
  end
end
