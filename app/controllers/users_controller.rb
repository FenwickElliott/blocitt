class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        # @user = User.new
        # props = ['name', 'email', 'password', 'password_confirmation']
        # props.each do |inst|
        #     @user.inst = params[:user][:inst]
        # end

        @user = User.new
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]

        if @user.save
            flash[:notice] = "Welcome to Blocitt #{@user.name}!"
            create_session(@user)
            redirect_to root_path
        else
            flash.now[:alert] = "Error"
            render :new
        end
    end
end
