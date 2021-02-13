class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def index
        if params[:plant_id] && @plant = Plant.find_by_id(params[:plant_id])
            @comment = @recipe.comments 
        elsif current_user
            @comment = current_user.comments.all 
        else
            @error = "Plant does not exist" if params[:plant_id]
            @comments = Comment.all 
        end
    end 

    def new
    end 
    
    def create 
    end 

    def show 
    end 

    def edit
    end 

    def update
    end 

    def destroy
    end 

    private 

        def comment_params
        end 
end
