module Api
  module V1
    class ShelvesController < ApplicationController
      before_action :set_shelf, only: [:show, :update, :destroy]
      before_action :authenticate_user!, except: [:show, :index]

      # GET /shelves
      def index
        @shelves = Shelf.all

        render json: @shelves, include: {products: {except: [:created_at, :updated_at]}}
      end

      # GET /shelves/1
      def show
        render json: @shelf, include: {products: {except: [:created_at, :updated_at]}}
      end

      # POST /shelves
      def create
        @shelf = Shelf.new(shelf_params)

        if @shelf.save
          render json: @shelf, status: :created, location: @shelf
        else
          render json: @shelf.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /shelves/1
      def update
        if @shelf.update(shelf_params)
          render json: @shelf
        else
          render json: @shelf.errors, status: :unprocessable_entity
        end
      end

      # DELETE /shelves/1
      def destroy
        @shelf.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shelf
          @shelf = Shelf.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shelf_params
          params.require(:shelf).permit(:name, :x_position, :y_position, products: [])
        end
    end
  end
end
