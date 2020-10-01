class ApplicationController < ActionController::API
  include JsonapiErrorsHandler
  ErrorMapper.map_errors!({
    'ActiveRecord::RecordNotFound' => 'JsonapiErrorsHandler::Errors::NotFound'
  })
  rescue_from ::StandardError, with: lambda { |e| handle_error(e) }

  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :unauthorized

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
    }
  end

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
