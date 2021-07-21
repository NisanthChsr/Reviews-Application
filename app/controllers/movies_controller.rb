class MoviesController < ApplicationController

    before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
        @movies = Movie.where(nil)
        @movies = Movie.filter(params[:filter]) if params[:filter].present?
        render json: @movies
    end

    def new
        @movie = Movie.new
    end

    def create
        if @current_user.admin?
            @movie = Movie.new(movie_params)
            
            if @movie.save
                render json: @movie
            else
                render json: @movie.errors
            end
        else
            render json: {error: "You're not authorized"}
        end 
    end

    def edit
        render json: @movie
    end
    
    def show
        render json: @movie
    end

    def update
        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors
        end
    end
    
    def destroy
        if @current_user.admin?
            @movie.destroy
            render json: @movie
        else
            render json: "You're not an admin"
        end
    end

    private

    def set_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :director, :rating)
    end

end
