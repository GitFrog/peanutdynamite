class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

   # query {
  #   :sort => new, old, chef, rating, stories
  #   :course => all, appetizers, mains, sweets, etc...
  #   :rtags =>
  #   :stags =>
  #   :pile => keeper, maybe, hate
  #   :storyview => mine, all
  #   :search => ???
  #   :page => 1, 2, 3, 4

end
