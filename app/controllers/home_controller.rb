class HomeController < ApplicationController
  def index
    render json: { message: "Rails is working!" }
  end
end
