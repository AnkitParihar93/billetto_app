class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def test_auth
    render json: {
      message: "Authenticated Successfully",
      current_user: current_user
    }
  end
end
