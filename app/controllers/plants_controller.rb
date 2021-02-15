class PlantsController < ApplicationController
    before_action :find_plant, :redirect_if_not_owner, only: [:edit, :update, :destroy]
    layout 'application'

    def index
        if params[:type_id] && @type = Type.find_by_id(params[:type_id])
            @plant = @type.plants.order_by_name
        else
            @plants = Plant.order_by_name
        end

        if params[:q]
            @plants = Plant.search(params[:q])
        else
            @plants = Plant.alpha.order_by_name.all
        end
    end

    def show
        @plant = Plant.find(params[:id])
    end

    def new
        if params[:type_id] && @type = Type.find_by_id(params[:type_id])
            @plant = @type.plants.build 
        else
            @plant = Plant.new 
            @plant.build_type
        end
    end

    def create
        @plant = current_user.plants.build(plant_params)
        if @plant.valid?
            @plant.save 
            redirect_to plant_path(@plant)
        else
            @type = Type.find_by_id(params[:type_id]) if params[:type_id]

            render :new 
        end
    end

    def edit 
    end

    def update
        if @plant.update(plant_params)
            redirect_to plant_path(@plant) 
        else 
            render :edit 
        end
    end

    def destroy
        @plant.destroy 
        redirect_to plants_path 
    end

    private 

        def plant_params
            params.require(:plant).permit(:name, :img, :description, :type_id, type_attributes: [:name])
        end

        def find_plant 
            @plant = Plant.find(params[:id])
        end 

        def redirect_if_not_owner
            if @plant.user != current_user
                if @user_id == nil 
                    redirect_to login_path, alert: "Sign in to edit a plant."
                else 
                    redirect_to user_path(current_user), alert: "You are not permitted to edit this plant."
                end
            end
        end 
end
