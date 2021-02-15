module PlantsHelper
    def display_type_fields(t) 
        if params[:type_id]
            t.hidden_field :type_id
        else
            render partial: 'type_select', locals: {f: t}
    end 
end
