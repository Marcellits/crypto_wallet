class WelcomeController < ApplicationController
  def index
    cookies[:test] = "testing cookies"
    session[:test] = "testing session"
    @my_name = params[:name]
  end
end
