class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in, :find_plant, :find_comment, :redirect_if_not_owner, only: [:edit, :update, :destroy]

    def index 
        if params[:plant_id] 
            @comments = @plant.comments 
        elsif current_user
            @comments = current_user.comments.all 
        else
            @error = "This plant does not exist." if params[:plant_id]
            @comments = comments.all 
        end 

    end 

    def new
        if params[:plant_id] && @plant = Plant.find_by_id(params[:plant_id])
            @comment = @plant.comments.new
        else
            @error = "Plant does not exist" if params[:plant_id]
            @comment = Comment.new 
        end
    end 
    
    def create
        @plant = Plant.find(params[:comment][:plant_id])
        @comment = current_user.comments.new(comment_params)
        
        if @comment.save
            redirect_to plant_path(@plant)
        else
            @error = @comment.errors.full_messages
            render :new 
        end
    end 

    def show
        @comment = Comment.find(params[:id]) 
    end 

    def edit
        @comment = Comment.find(params[:id])
    end 

    def update
        @comment = current_user.comments.find(params[:id])

        if @comment.update(comment_params)
            redirect_to comment_path(@comment)
        else
            @error = @comment.errors.full_messages
            render :edit 
        end
    end 

    def destroy
        @comment = current_user.comments.find(params[:id])
        @plant = Plant.find(params[:comment][:plant_id]) 

        if @comment.destroy 
            flash[:success] = "Your comment was removed."
            redirect_to plants_path(@plant)
        else
            @error = @comment.errors.full_messages
            render :edit 
        end 
    end 

    private 

        def find_comment
            @comment = Comment.find(params[:id])
        end

        def find_plant
            @plant = Plant.find_by_id(params[:plant_id])
        end

        def redirect_if_not_owner 
            if @comment.user != current_user
                redirect_to user_path(current_user), alert: "You are not permitted to edit this comment."
            end
        end

        def redirect_if_not_logged_in
            if session[:user_id] == nil
                redirect_to login_path
            end
        end

        def comment_params
            params.require(:comment).permit(:content, :plant_id, :user_id)
        end 
end
