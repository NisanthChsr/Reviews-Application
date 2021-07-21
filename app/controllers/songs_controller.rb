class SongsController < ApplicationController

    before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
        @songs = Song.where(nil)
        @songs = Song.filter(params[:filter]) if params[:filter].present?
        render json: @songs
    end

    def new
        @song = Song.new
    end

    def create
        if @current_user.admin?
            @song = Song.new(movie_params)
            
            if @song.save
                render json: @song
            else
                render json: @song.errors
            end
        else
            render json: {error: "You're not authorized"}
        end 
    end

    def edit
        render json: @song
    end
    
    def show
        render json: @song
    end

    def update
        if @song.update(movie_params)
            render json: @song
        else
            render json: @Song.errors
        end
    end
    
    def destroy
        if @current_user.admin?
            @song.destroy
            render json: @song
        else
            render json: "You're not an admin"
        end
    end

    private

    def set_movie
        @song = Song.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :singer, :rating)
    end

end
