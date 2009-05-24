require File.expand_path(File.dirname(__FILE__) + '/../plugin_spec_helper')
require File.expand_path(File.dirname(__FILE__) + "/../../lib/swfobject_view_helper")

include ActionView::Helpers

describe SwfObjectHelper do
  include SwfObjectHelper
  
  describe :swfobject_tag do
    before(:each) do
      EnvChecker.stub!(:development?).and_return(false)
      EnvChecker.stub!(:production?).and_return(true)
      self.stub!(:compute_public_path).and_return('/applets/url.swf')
    end
    
    it "should call swfobject.embedSWF" do
      html = swfobject_tag("url")
      html.should have_tag('script', /swfobject.embedSWF/)
      html.should have_tag('script', /"\/applets\/url.swf"/)
    end
    
    it "should check for the js fn, in development mode " do
      EnvChecker.stub!(:development?).and_return(true)
      EnvChecker.stub!(:production?).and_return(false)      
      html = swfobject_tag("url", :verify_file_exists => false)

      # helpful reminder to developers if the javascript isn't there'
      html.should have_tag('script', /Did you forget to include/)
    end
    
    it "should default the id to the basename" do
      html = swfobject_tag("url")
      html.should have_tag('div#url')
      html.should have_tag('script', /, "url"/)
    end
    
    it "should default to version 8" do
      html = swfobject_tag("url")
      html.should have_tag('script', /"8,0,24,0"/)
    end
    
    it "should set the id" do
      html = swfobject_tag("url", :id => 'flash-id')
      html.should have_tag('div#flash-id')
      html.should have_tag('script', /, "flash-id"/)
    end
    
    it "should encode the flash variables" do
      html = swfobject_tag("url", :variables => {:a => 1, :b => 2})
      html.should have_tag('script', /"a": 1/)
      html.should have_tag('script', /"b": 2/)
    end
    
    it "should encode the parameters" do
      html = swfobject_tag("url", :parameters => {:wmode => 'wmode-value'})
      html.should have_tag('script', /"wmode": "wmode-value"/)
    end
  end
end
