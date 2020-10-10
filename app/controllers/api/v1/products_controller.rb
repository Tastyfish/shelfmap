module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]
      before_action :authenticate_user!, except: [:show, :index]

      # GET /products
      def index
        @products = Product.all

        render json: @products, include: {shelves: {except: [:created_at, :updated_at]}}
      end

      # GET /products/1
      def show
        render json: @product, include: {shelves: {except: [:created_at, :updated_at]}}
      end

      # POST /products
      def create
        @product = Product.new(product_params)

        if @product.save
          render json: @product, status: :created, location: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /products/1
      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # DELETE /products/1
      def destroy
        @product.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_product
          @product = Product.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def product_params
          params.require(:product).permit(:name, :in_stock?, shelves: [])
        end
    end
  end
end
