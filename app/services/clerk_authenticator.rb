require "jwt"
require "net/http"
require "json"

class ClerkAuthenticator

  JWKS_URL = "https://amazed-dingo-9.clerk.accounts.dev/.well-known/jwks.json"

  def self.verify(token)
    return nil if token.blank?
    decoded_token = JWT.decode(
      token,
      nil,
      true,
      decode_options
    )
    decoded_token.first

  rescue JWT::ExpiredSignature
    Rails.logger.error("JWT expired")
    nil

  rescue JWT::DecodeError => e
    Rails.logger.error("JWT VERIFY ERROR: #{e.message}")
    nil
  end

  private

  def self.decode_options
    {
      algorithms: ["RS256"],
      jwks: jwks,
      verify_iss: true,
      iss: "https://amazed-dingo-9.clerk.accounts.dev",
      leeway: 240
    }
  end

  def self.jwks
    @jwks ||= begin
      uri = URI(JWKS_URL)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end