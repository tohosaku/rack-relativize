require 'spec_helper'

describe Rack::Relativize do
  include Rack::Test::Methods

  let(:app) { Rack::Relativize.new(TestRackApp.new) }

  it "makes no change to response status" do
    get "/"
    last_response.should be_ok
  end

  it "relativize img attribute" do
    get "/"
    last_response.body.should include('<img src="test">')
  end

  it "content length changed after relativize" do
    get "/"
    last_response.headers['Content-Length'].should == '<img src="test">'.size.to_s
  end


  it "relativize subdir contents" do
    get "/sub/"
    last_response.body.should include('<img src="../test">')
  end

  it "subdir content length changed after relativize" do
    get "/sub/"
    last_response.headers['Content-Length'].should == '<img src="../test">'.size.to_s
  end
end
