# tie everyting together
require_relative "view"
require_relative "recipe"
require_relative "scrape_all_recipes_service"

class Controller
   def initialize(cookbook)
     @cookbook = cookbook
     @view = View.new
   end

   def list
    @view.display(@cookbook.all)
   end

   def create
    name = @view.ask_user_for("name")
    description = @view.ask_user_for("description")
    prep_time = @view.ask_user_for("prep_time")
    @cookbook.add_recipe(Recipe.new(name: name,description: description, prep_time: prep_time))
   end

   def destroy
    list
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index)
   end

   def import
    #1. Ask the user for the ingridient
    ingridient = @view.ask_user_for("ingridient")
    results = ScrapeAllRecipesService.new(ingridient).call
    #6. Display the results
    @view.display(results)
    #7. Ask the user for the recipe to import
    index = @view.ask_user_for_index
    #8. Add it to cookbook
    @cookbook.add_recipe(results[index])
    #9. Display
    list
   end

  def mark_as_done
    # 1. Display recipes
    display_recipes
    # 2. Ask user for an index (view)
    index = @view.ask_user_for_index
    # 3. Mark as done and save (repo)
    @cookbook.mark_recipe_as_done(index)
    # 4. Display recipes
    display_recipes
  end

end
