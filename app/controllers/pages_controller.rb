class PagesController < ApplicationController

  def home
    @errormsg = params[:errormsg]
  end

  def about
  end


end
