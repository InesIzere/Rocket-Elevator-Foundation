class UserController < ApplicationController
    def create
        @users = User.new(user_params)
       
        @users.save
        redirect_to @users
end

  private
    def user_params
        params.require(:users).permit(:email, :encrypted_password)
    end
end
