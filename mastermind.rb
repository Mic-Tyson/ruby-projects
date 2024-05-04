# to create the code, the class will have access to a hat of 
# potential options
# from that hat we will keep on picking random elements, while using uniq to ensure
# that we haven't reselected an option
# when guessing, we first pass an exact match algorithm.
# we then pass a partial match algorithm, skipping correct guesses, every guess against every
# elem in the code
# we then use symbols to display exact, partial, and full matches


class Game
  
  def initialize

  end


  def play

  end

  def get_guess


  end


end

class Mastermind
  attr_reader :code

  def initialize(code_maker)
    @code_maker = code_maker
    @code = @code_maker.make_code
  end

  
end

class Code_maker
  @@CODE_OPTIONS = ["red", "orange", "yellow", "green", "blue", "purple", "black", "white"].freeze
  @@CODE_LENGTH = 5

  def make_code
    code = @@CODE_OPTIONS.sample(@@CODE_LENGTH).uniq # ideally get 5 random elems
    code += @@CODE_OPTIONS.sample(@@CODE_LENGTH - code.size) until code.size == @@CODE_LENGTH # Keep adding samples
    return code
  end

end


class Guess
  

end


def compare_guess(guess)

end

def compare_exact(guess, code)
  code.each_with_index.reduce([]) do |a, (elem, i)|
    guess[i] == elem ? a.push('O') : a.push('X')
  end
end

def compare_partial(a, guess, code)


end



test = Code_maker.new().make_code

p compare_exact(["red", "white", "blue", "orange", "yellow"], test)
