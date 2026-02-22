class HomeController < ApplicationController
  def index
    render json: { message: "HI Charan, Welcome to the Rails, Rails is working!" }
  end
end
