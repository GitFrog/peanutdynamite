module UsersHelper

def sort_options
     
  (link_to "newest", :action => "show", :controller => "users", :query => @query[:sort => "new"]) + " | " + \
  (link_to "oldest", :action => "show", :controller => "users", :query => @query[:sort => "old"]) + " | " + \
  (link_to "by chef", :action => "show", :controller => "users", :query => @query[:sort => "chef"]) + " | " + \
  (link_to "rating", :action => "show", :controller => "users", :query => @query[:sort => "rate"]) + " | " + \
  (link_to "stories", :action => "show", :controller => "users", :query => @query[:sort => "story"])
  
end

end
