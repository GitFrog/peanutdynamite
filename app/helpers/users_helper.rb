module UsersHelper

def sort_options

  (link_to "newest", :action => "show", :controller => "users", :sortby => "new", :course => @course, :keeper_or_maybe => @keeper_or_maybe) + " | " + \
  (link_to "oldest", :action => "show", :controller => "users", :sortby => "old", :course => @course, :keeper_or_maybe => @keeper_or_maybe) + " | " + \
  (link_to "by chef", :action => "show", :controller => "users", :sortby => "chef", :course => @course, :keeper_or_maybe => @keeper_or_maybe) + " | " + \
  (link_to "rating", :action => "show", :controller => "users", :sortby => "rate", :course => @course, :keeper_or_maybe => @keeper_or_maybe) + " | " + \
  (link_to "stories", :action => "show", :controller => "users", :sortby => "story", :course => @course, :keeper_or_maybe => @keeper_or_maybe)
 end

end
