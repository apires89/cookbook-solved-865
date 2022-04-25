# create instances of Recipe
class Recipe
  attr_reader :name, :description, :prep_time
  def initialize(attributes={})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
  end
end
