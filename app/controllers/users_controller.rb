class UsersController < ApplicationController
before_action :authorize

    def create
        user = User.create(user_params)
        if user
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    private

    def authorize
        return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
      end

    def user_params
        params.permit(:username,:password,:password_coonfirmation)
    end
end
