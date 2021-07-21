class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]
   
    def index
        @books = Book.where(nil)
        @books = Book.filter(params[:filter]) if params[:filter].present?
        render json: @books
    end

    def new
        @book = Book.new
    end

    def create
        if @current_user.admin?
            @book = Book.new(book_params)
            if @book.save
                render json: @book
            else
                render json: @book.errors
            end
        else
            render json: {error: "You're not authorized"}
        end
    end
    
    def edit
        render json: @book
    end

    def show
        render json: @book
    end

    def update
        if @book.update(book_params)

            render json: @book
        else
            render json: @book.errors
        end
    end
    
    def destroy
        if @current_user.admin?
            @book.destroy
            render json: @book
        else
            render json: "You're not an admin"
        end
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:title, :author, :rating)
    end
end
