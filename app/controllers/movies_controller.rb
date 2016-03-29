class MoviesController < ApplicationController
  
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    # binding.pry
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

   if @movie.update(post_params)
    redirect_to movies_path
   else
    render :edit
   end
  end

  def new
    @movie = Movie.new
  end

  def create  
    @movie = Movie.new(post_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def post_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :description, :poster_image_url, :release_date)
  end

end
