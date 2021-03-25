class PagesController < ApplicationController

    def index
    end

    def commercial
    end

    def residential
    end

    def quote
    end

    # skip_before_action :authenticate_user!, :only => [:index, :residential, :commercial, :quote]

    def after_sign_in_path_for(resource)
        if user.supervisor_role?
            app_admin_path
        end
        if user.user_role? 
            redirect_to root_path
        end
    end

end
