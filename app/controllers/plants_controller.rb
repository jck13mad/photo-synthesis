class PlantsController < ApplicationController
    before_action :find_plant, :redirect_if_not_owner, only: [:edit, :update, :destroy]
    layout 'plant'

    def index
        if params[:type_id] && @type = Type.find_by_id(params[:type_id])
            @plant = @type.plants.order 
        else
            @plants = Plant.order
        end
    end

    def new
        if params[:type_id] && @type = Type.find_by_id(params[:type_id])
            @plant = @type.plants.build 
        else
            @plant = Plant.new 
            @plant.build_brand
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
            params.require(:plant).permit(:name, :description, :type_id, type_attributes: [:name])
        end

        def find_plant 
            @plant = Plant.find(params[:id])
        end 

        def redirect_if_not_owner
            if @plant.user != current_user
                redirect_to user_path(current_user), alert: "You are not permitted to edit this plant."
            end
        end 
end
