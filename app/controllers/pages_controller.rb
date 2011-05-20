class PagesController < ApplicationController

  def home
    #Recipe.reset_column_information
    #Story.reset_column_information
    #User.reset_column_information
    #Favourite.reset_column_information
    @stories = Story.find(:all, :order => "created_at desc", :limit => 3)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  def about
  end


end
