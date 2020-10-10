class ApplicationController < ActionController::API
  respond_to :json

  include JsonapiErrorsHandler
  ErrorMapper.map_errors!({
    'ActiveRecord::RecordNotFound' => 'JsonapiErrorsHandler::Errors::NotFound'
  })
  rescue_from ::StandardError, with: lambda { |e| handle_error(e) }

  def route_not_found
    render json: {
      errors: [
        status: 404,
        title: "Path not found.",
        detail: "This is an invalid route in the API.",
        source: {
          pointer: "/:path"
        }
      ]
    }, status: :not_found
  end

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  private

  def not_authorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
