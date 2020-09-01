class WelcomeController < ApplicationController
  def index
    @my_name = params[:name]
  end
end
