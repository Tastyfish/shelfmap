module Api
  module V1
    class SiteController < ApplicationController
      before_action :set_site
      before_action :authorize_access_request!, except: [:show]

      # GET /site
      def show
        render json: @site
      end

      # PATCH /site
      def update
        settings_params.keys.each do |key|
          Setting.send("#{key}=", settings_params[key].strip) unless settings_params[key].nil?
        end

        show
      end

      private

      def set_site
        @site = {
          site_name: Setting.site_name,
          account_creation_enabled?: Setting.account_creation_enabled?,
          map_name: Setting.map_name
        }
      end

      def settings_params
        params.permit(:site_name, :account_creation_enabled?, :map_name)
      end
    end
  end
end
