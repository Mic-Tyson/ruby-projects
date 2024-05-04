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


def compare_guess(guess, code)
  a = []
  a += compare_exact(guess,code)
  compare_partial(a, guess, code)
end

def compare_exact(guess, code)
  code.each_with_index.reduce([]) do |a, (elem, i)|
    guess[i] == elem ? a.push('O') : a.push('X')
  end
end

def compare_partial(a, guess, code)
  # algorithm taken from my bubble_sort, so could be refactored if I modify my sort to accept predicates
  code.each_with_index.reduce(a) do |a, (elem, i)| 
    unless a[i] == 'O'
      j = 0
      while j < code.length
          if guess[i] == code[j]
            a[i] = '?'
          end
          j+=1
        end
      end
        a
  end
end



test = Code_maker.new().make_code
guess = ["red", "white", "blue", "orange", "yellow"]

p test
p guess
p compare_guess(guess, test)