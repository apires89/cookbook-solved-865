require "open-uri"
require "nokogiri"
require_relative "recipe"
require "byebug"

class ScrapeAllRecipesService
  def initialize(ingridient)
    @ingridient = ingridient
  end

  def call
    html = URI.open("https://www.allrecipes.com/search/results/?search=#{@ingridient}").read
    doc = Nokogiri::HTML(html,nil,"utf-8")
    results = []
     doc.search(".card__detailsContainer").first(5).each do |element|
      name = element.search(".card__title.elementFont__resetHeading").text.strip
      description = element.search(".card__summary").text.strip
    ## logic for the prep time
      html_for_prep = element.search(".card__titleLink").first.attributes["href"].text.strip
      prep_doc = Nokogiri::HTML(URI.open(html_for_prep).read,nil,"utf-8")
      prep_element = prep_doc.search(".recipe-meta-item").find do |element|
        element.text.strip.match?(/prep/i)
      end

      prep_time = prep_element ? prep_element.text.strip : nil
      results << Recipe.new(name: name,description: description, prep_time: prep_time)
    #logic of scrapping

    #2. open url
    #3. parse HTML
    #4. For the first five results
    #5. create a recipe! and store it into the results
     end
    # must return me an array of instances of recipe!
    results
  end
end

#instance of service
#p ScrapeAllRecipesService.new("chocolate").call
