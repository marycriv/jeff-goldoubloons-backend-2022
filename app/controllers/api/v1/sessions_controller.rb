module Api 
    module V1 
        class SessionsController < ApplicationController
            def create
                @user = User.find_by(username: session_params[:username])
            
                if @user && @user.authenticate(session_params[:password])
                login!
                render json: {
                    status: 200,
                    logged_in: true,
                    user: @user,
                    relationships: @user.coins
                }
                else
                render json: { 
                    status: 401,
                    errors: ['no such user, please try again']
                }
                end
            end

            def is_logged_in?
                if logged_in? && current_user
                render json: {
                    status: 200,
                    logged_in: true,
                    user: current_user,
                    relationships: current_user.coins
                }
                else
                render json: {
                    logged_in: false,
                    message: 'no such user'
                }
                end
            end

            def destroy
                logout!
                render json: {
                    status: 200,
                    logged_out: true
                }
            end

            private

            def session_params
                params.require(:user).permit(:username, :password)
            end
        end
    end
end