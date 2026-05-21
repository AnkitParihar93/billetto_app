class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

  before_action :authenticate_user!

  attr_reader :current_user

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last

    return unauthorized!("Missing token") unless token.present?

    begin
      decoded = ClerkAuthenticator.verify(token)
    rescue => e
      return unauthorized!("Invalid or expired token")
    end

    return unauthorized!("Invalid token") unless decoded.present?

    clerk_user_id = decoded["sub"]

    begin
      clerk_user = Clerk::UserService
        .new(clerk_user_id)
        .call
    rescue => e
      return unauthorized!("Clerk user fetch failed")
    end

    return unauthorized!("User not found") unless clerk_user.present?

    email = clerk_user.dig("email_addresses", 0, "email_address")

    @current_user = User.find_or_initialize_by(clerk_user_id: clerk_user_id)
    @current_user.email = email
    @current_user.save!

    true
  end

  def current_user
    @current_user
  end

  private

  def unauthorized!(message = "Unauthorized")
    render json: {
      error: message
    }, status: :unauthorized
  end

  def sync_clerk_user(payload)
    clerk_user_id = payload["sub"]

    User.find_or_create_by(clerk_user_id: clerk_user_id) do |user|
      user.email = payload.dig("email_addresses", 0, "email_address") || "no-email"
    end
  end
end