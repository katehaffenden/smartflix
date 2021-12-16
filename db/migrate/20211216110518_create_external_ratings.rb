class CreateExternalRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :external_ratings do |t|
      t.string :source
      t.float :rating

      t.timestamps
    end
  end
end
