class ApplicationController < ActionController::Base

    private 
        def current_user
            @current_user ||= User.find_by(session[:user_id]) if session[:user_id]
        end 

        def logged_in?
            !!current_user
        end 
end
