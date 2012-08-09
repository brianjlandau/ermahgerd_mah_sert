class Main
  get "/" do
    mustache :convert_page_form
  end
  
  get '/convert' do
    WebPageConverter.new(params[:url], Ermahgerd).convert
  end
end
