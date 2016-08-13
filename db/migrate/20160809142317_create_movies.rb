class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies, id: false do |t|
      t.string :imdb_id, :primary_key => true
      t.string :title
      t.string :image_url
      t.string :year
      t.string :movie_type
      t.string :genre
      t.string :runtime
      t.string :director
      t.string :writer
      t.string :actor
      t.string :plot
      t.string :award

      t.timestamps
    end
  end
end
