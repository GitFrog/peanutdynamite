module UsersHelper

def sort_options

  (link_to "newest", :action => "show", :controller => "users", :sort => "new", :show => @show, :keep => @keep) + " | " + \
  (link_to "oldest", :action => "show", :controller => "users", :sort => "old", :show => @show, :keep => @keep) + " | " + \
  (link_to "by chef", :action => "show", :controller => "users", :sort => "chef", :show => @show, :keep => @keep) + " | " + \
  (link_to "rating", :action => "show", :controller => "users", :sort => "rate", :show => @show, :keep => @keep) + " | " + \
  (link_to "stories", :action => "show", :controller => "users", :sort => "story", :show => @show, :keep => @keep)
 end

end
