begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

# just enough infrastructure to get 'assert_select' to work
require 'action_controller'
require 'action_controller/assertions/selector_assertions'
include ActionController::Assertions::SelectorAssertions
