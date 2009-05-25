require File.expand_path(File.dirname(__FILE__) + '/../plugin_spec_helper')
require File.expand_path(File.dirname(__FILE__) + "/../../lib/applet_view_helper")

include ActionView::Helpers
require 'openlaszlo_build_support'

describe AppletHelper  do
  include AppletHelper

  describe :applet_tag do
    before(:each) do
      EnvChecker.stub!(:development?).and_return(false)
      EnvChecker.stub!(:production?).and_return(true)
    end

    it "should call swfobject.embedSWF" do
      html = applet_tag("url")
      html.should have_tag('script', /swfobject.embedSWF/)
      html.should have_tag('script', /"\/applets\/url.swf"/)
    end

    it "should compile debug swf when debug option is set" do
      # don't need to stub this in production, since it doesn't compile then'
      OpenLaszlo::Rails.stub(:update_asset)
      # mock development
      EnvChecker.stub!(:development?).and_return(true)
      EnvChecker.stub!(:production?).and_return(false)

      params[:debug] = "true"
      html = applet_tag("url", :verify_file_exists => false)
      html.should have_tag('script', /swfobject.embedSWF/)
      html.should have_tag('script', /"\/applets\/url-debug.swf"/)
    end

  end
end
