class MoviesController < ApplicationController
  def index
    @movies = Movie.search(params).paginate(:page => params[:page])
    #, :per_page => 4

    if params[:search]
      #ApiRequest.cache(params[:search], Imdb::CACHE_POLICY) do # cache every requests for a day
        begin
          @search = Imdb.search(params[:search], params[:year]) # fetch data from IMDb
          return flash.now[:info] = "No movies found with the name #{params[:search]}" if @search['Response'] == "False"
          Movie.add_movies(@search["Search"]) # add new movies from json to db
        rescue
          flash.now[:warning] = "No contact with the server, please try again later"
        end
      #end
    end

  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create

  end

  def new
    @movie = Movie.new(movie_params)
  end

  def update

  end

  def speed # Speed testing things
    start_time = (Time.now.to_f * 1000).to_i
    stop_time = (Time.now.to_f * 1000).to_i
    time = "#{stop_time - start_time}"
    respond_to do |format|
      format.html
      format.json { render json: time }
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :image_url)
  end
end
