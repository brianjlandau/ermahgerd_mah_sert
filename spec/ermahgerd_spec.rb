require 'spec_helper'

describe Ermahgerd do
  it "should translate the string" do
    Ermahgerd.new("ohmygod it's my site").convert.should == 'ERMAHGERD ERTS MAH SERT'
  end
end
