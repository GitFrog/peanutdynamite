class PagesController < ApplicationController

  def home
    @stories = Story.find(:all, :order => "story_date desc", :limit => 3)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  def about
  end


end
