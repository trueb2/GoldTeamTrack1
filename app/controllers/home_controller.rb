class HomeController < ApplicationController

  def index
    puts "HomeController#index"
    if params[:new_event] == "1"
      puts "params[:new_event] == 1"
      flash[:new_event] = 1
    end   
  end

end
