class AddMovieRefToExternalRatings < ActiveRecord::Migration[6.0]
  def change
    add_reference :external_ratings, :movie, null: false, foreign_key: true
  end
end
