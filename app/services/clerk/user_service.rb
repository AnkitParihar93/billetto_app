require 'httparty'
module Clerk
  class UserService
    include HTTParty
    base_uri 'https://api.clerk.com/v1'
    def initialize(user_id)
      @user_id = user_id
    end
    
    def call
      response = self.class.get(
        "/users/#{@user_id}",
        headers: {
          "Authorization" => "Bearer #{ENV['CLERK_SECRET_KEY']}"
        }
      )
      response.parsed_response
    end
  end
end