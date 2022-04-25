require "csv"
require "byebug"
require_relative "recipe"
# store recipes

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_to_csv
  end




  private

  def load_csv
    # iterate over the csv rows
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # fetch the name and the description from the row
      # instantiate the Recipe
      # add it to the @recipes
      @recipes << Recipe.new(row)
    end

   def save_csv
      #1. open the csv file
      CSV.open(@csv_file_path,"wb") do |csv|
      #2. iterate @recipes
      csv << ["name","description","prep_time"]
        @recipes.each do |recipe|
        #3. for each of the recipes save the name and description
        #4. push it into the csv
        csv << [recipe.name, recipe.description, recipe.prep_time]
        end
      end
   end


  end


end
