class PostsController < ApplicationController

    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
        render json: @posts
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = @current_user.id
        if Category.find_by(category_name: params[:commentable_name]).isReviewable?
            if params[:commentable_name]=='movies'
                @post.commentable=Movie.find_by(id: params[:commentable_id])
            elsif params[:commentable_name]=='books'
                @post.commentable=Book.find_by(id: params[:commentable_id])
            end

            if @post.save  && @post.commentable_id
                render json: @post, status: :created, location:@post
            else
                render json:{errors: @post.errors,message:"Check the api request properly"}, status: :unprocessable_entity
            end
        else
            render json:{message: "Specified controllers are not built so can not review this category"}
        end
        
    end

    def custom_show
        
        if Category.find_by(category_name: params[:commentable_name]).isReviewable?
            if params[:commentable_name]=="movies"
                @item=Movie.find_by(id: params[:commentable_id])
            elsif params[:commentable_name]=="books"
                @item=Book.find_by(id: params[:commentable_id])
            end
            if @item
                render json: {Item:@item,posts: @item.posts}
            else
                render json: {message: "Not present"}
            end
        else
            render json:{message: "Not reviewable"}
        end
        
        
    end

    def show
        render json: @post
    end

    def edit
        if @current_user.id==@post.user_id
            render json: @post
        else
            render json: "You can't do that!!"
        end
    end
    
   
    def update
        if @current_user.id == @post.user_id
            if @post.update(post_params)
                render json: @post
            else
                render json: @post.errors
            end
        else
            render json: "You can't do that!!"
        end
    end
    
    def destroy
        if @current_user.id == @post.user_id
            @post.destroy
            render json: @post
        else
            render json: "You can't do that!!"
        end
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:review)
    end

end
