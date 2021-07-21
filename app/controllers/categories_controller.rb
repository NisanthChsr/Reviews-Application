class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def show
        render json: @category
    end

    def index
        @categories = Category.all
        render json: @categories
    end

    def new
        @category = Category.new
    end
    
    def edit
    end

    def create
        if @current_user.admin?
            @category = Category.new(category_params)
            if@category.save
                render json:@category, status: :created, location:@category
            else
                render json:@category.errors, status: :unprocessable_entity
            end
        else
            render json:"Access Denied!! You can't add Categories"
        end
    end

    def update
        if @current_user.admin?
            if@category.update(category_params)
                render json:@category
            else
                render json:@category.errors, status: :unprocessable_entity
            end
        else
            render json: "Access Denied!! You can't update Categories"
        end
    end

    def destroy
        if @current_user.admin?
            @category.destroy
            render json: "The Category is deleted"
        else
            render json:"Access Denied!! You can't Delete Categories"
        end
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:category_name)
    end

end
