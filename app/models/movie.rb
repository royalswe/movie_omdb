class Movie < ApplicationRecord

validates :imdb_id, uniqueness: true

  def self.search(params)
    story = order('created_at DESC') # note: default is all, just sorted
    story = where('title ILIKE ? AND year ILIKE ?', "%#{params[:search]}%", "%#{params[:year]}%") if params[:search].present?
    story
  end

  def self.add_movies(movies)
    ActiveRecord::Base.transaction do # performs all inserts in a single transaction
      movies.each do |element|
        next if element['Poster'] == "N/A" # dont want movies without image
        if !Movie.exists?(element['imdbID']) #ActiveRecord::Base.connection.execute('SELECT 1 FROM movies where imdb_id = "imdbID"').blank?
          info = Imdb.get_info(element['imdbID']) # fetch all info for the movie

          Movie.create(imdb_id: info['imdbID'], title: info['Title'],
            image_url: info['Poster'], year: info['Year'], movie_type: info['Type'],
            genre: info['Genre'], runtime: info['Runtime'], director: info['Director'],
            writer: info['Writer'], actor: info['Actors'], plot: info['Plot'], award: info['Awards'])
        end
      end
    end
  end

end
