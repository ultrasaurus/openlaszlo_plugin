# this is only required for view_helper exmaples
# other examples can run stand-alone
begin
  require File.dirname(__FILE__) + '/../../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end
