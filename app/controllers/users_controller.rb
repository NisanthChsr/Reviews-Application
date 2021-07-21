class UsersController < ApplicationController
    skip_before_action :authenticate_request
    before_action :set_user, only: [:show, :edit, :update, :destroy]
   
    def index
        @users = User.all
        render json: @users
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        #@user.user = current_user
        if @user.save
            #flash[:notice] = 'New user has come Hurraayyyy!!!'
            render json: @user
        else
            render json: @user.errors
        end
    end
    
    def edit
        render json: @user
    end

    def show
        render json: @user
    end

    def update
        if @user.update(user_params)
            #flash[:notice] = 'user is updated successfully.'
            render json: @user
        else
            render json: @user.errors
        end
    end
    
    def destroy
        @user.destroy
        render json: @user
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
