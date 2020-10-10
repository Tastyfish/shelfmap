module Api
  module V1
    class UserController < ApplicationController
      before_action :authenticate_user!

      # GET /user
      # Show current user
      def show
        render json: current_user, except: [:id]
      end
    end
  end
end
