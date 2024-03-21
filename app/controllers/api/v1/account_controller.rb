class Api::V1::AccountController < Api::V1::BaseController
  def create
    errors = validate_params
    return render_unauthorized(errors) if errors.present?

    account = Account.new(create_params)
    if account.save
      render json: AccountSerializer.new(account).serialize, status: :created
    else
      render json: {
        # code: Settings.error.code.unprocessable_entity,
        message: account.errors.full_messages.join("\n")
      }, status: :unprocessable_entity
    end
  end
  def validate_params
    errors = []
    if decoded_authorization_token[:email] != create_params[:email]
      errors << "email does not match with id token."
    end
    if decoded_authorization_token[:user_id] != create_params[:uid]
      errors << "uid does not match with id token."
    end
    errors
  end

  def render_unauthorized(errors)
    render json: {
      # code: Settings.error.code.auth.unauthorized_request,
      message: errors.join("\n")
    }, status: :unauthorized
  end

  def create_params
    params.permit(:email)
  end

  def update_params
    params.permit(:status)
  end
end
