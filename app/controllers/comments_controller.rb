class CommentsController < ApplicationController

    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    def index
        @comments = Comment.all
        render json: @comments
    end

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = @current_user.id
        @comment.post_id = params[:post_id]
        if @comment.save && @comment.post_id
            render json: @comment
        else
            render json: @comment.errors
        end
    end

    def edit
        render json: @comment
    end
    
    def show
        render json: @comment
    end

    def show_by_posts
        @comments = Comment.where(post_id: params[:post_id])
    
        @post = Post.find(params[:post_id])

        if @comments && @post
            render json: {post: @post, comment: @comments, user: User.find(@post.user_id).as_json(only: [:username,:email])}
        else
            render json: {message: "Not present"}
        end
    end

    def show_by_posts_users
        @comments = Comment.where(post_id: params[:post_id]).where(user_id: params[:user_id])
    
        @post = Post.find(params[:post_id])
        if @comments && @post
            render json: {post: @post, comment: @comments, user: User.find(@post.user_id).as_json(only: [:username,:email])}
        else
            render json: {message: "Not present"}
        end
    end
    
    def update
        if @current_user.admin? || @current_user == @Comment.user_id
            if @comment.update(comment_params)
                render json: @comment
            else
                render json: @comment.errors
            end
        else
            render json: "You're not an admin"
        end
    end
    
    def destroy
        if @current_user.admin? || @current_user == @Comment.user_id
            @comment.destroy
            render json: @comment
        else
            render json: "You're not an admin"
        end
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:description)
    end

end
