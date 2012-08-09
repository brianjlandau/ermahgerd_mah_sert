require 'open-uri'

class WebPageConverter
  attr_reader :url, :translator, :html

  def initialize(url, translator)
    @url = url
    @translator = translator
    @html = Nokogiri::HTML(fetch_web_page)
  end

  def convert
    translate_text
    add_base_element
    html.to_s
  end

  private

  def fetch_web_page
    open(url).read
  end

  def translate_text
    html.xpath('//body//text()').each do |node|
      unless node.is_a?(Nokogiri::XML::CDATA)
        node.content = translator.new(node.text).convert
      end
    end
  end
  
  def add_base_element
    base_element = Nokogiri::XML::Element.new("base", html)
    base_element[:href] = url
    html.xpath('//head').first.add_child(base_element)
  end
end