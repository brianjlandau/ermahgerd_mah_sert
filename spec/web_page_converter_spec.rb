require 'spec_helper'

describe WebPageConverter do
  let(:converter){ WebPageConverter.new('http://www.example.com/', Ermahgerd) }
  before do
    WebPageConverter.any_instance.stub(:fetch_web_page => "<html><head><script>bougs</script><style>blah</style></head><body><h1>ohmygod it's my site</h1></body></html>")
  end
  
  it "should translate the text" do
    converter.convert.index('<h1>ERMAHGERD ERTS MAH SERT</h1>').should_not be_nil
  end
  
  it "should add a base tag" do
    converter.convert.index('<base href="http://www.example.com/"').should_not be_nil
  end

  it "should not alter script tags" do
    converter.convert.index('<script>bougs</script>').should_not be_nil
  end

  it "should not alter style tags" do
    converter.convert.index('<style>blah</style>').should_not be_nil
  end
end
