# get/set user input

class View
  def display(recipes)
    status = recipe.done? ? "[X]" : "[ ]"
    puts "#{index + 1}. #{status} #{recipe.name}: #{recipe.description} (#{recipe.prep_time})"
    end
  end

  ## get index

  # get user input
  def ask_user_for_index
    puts "Index?"
    gets.chomp.to_i - 1
  end


  def ask_user_for(input)
    puts "What is the #{input}?"
    gets.chomp
  end




end
