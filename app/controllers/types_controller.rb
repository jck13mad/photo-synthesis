class TypesController < ApplicationController

    def new 
        @type = Type.new 
    end

    def create 
        @type = Type.new(type_params)
        if @type.save 
            redirect_to type_path(@type)
        else
            render :new 
        end
    end 

    def show
        @type = Type.find(params[:id])
    end

    def index
        @types = Type.all 
    end

    private 

        def type_params
            params.require(:type).permit(:name, plants_attributes: [:name, :description, :img])
        end
end
