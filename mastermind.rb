# to create the code, the class will have access to a hat of
# potential options
# from that hat we will keep on picking random elements, while using uniq to ensure
# that we haven't reselected an option
# when guessing, we first pass an exact match algorithm.
# we then pass a partial match algorithm, skipping correct guesses, every guess against every
# elem in the code
# we then use symbols to display exact, partial, and full matches

class Game
  # handle io, and mastermind

  def initialize
    @mastermind = Mastermind.new
  end

  def play
    puts "Guess my code using the following colors #{@mastermind.code_maker.CODE_OPTIONS}"
    12.times do
      guess = get_guess
      feedback = @mastermind.compare_guess(guess)
      p feedback
      return p 'you win' if feedback.all?('O')
    end
    "You lose! The correct code was: #{@mastermind.code}"
  end

  private

  def validate_guess?(guess)
    guess.size == @mastermind.code_maker.CODE_LENGTH &&
      guess.all? { |elem| @mastermind.code_maker.CODE_OPTIONS.include?(elem) }
  end

  def get_guess
    # guesses will be of the form g1, g2, g3
    guess = ''
    puts 'Enter your guess'
    loop do
      guess = gets.chomp.downcase
      guess = guess.split(', ')
      return guess if validate_guess?(guess)

      puts "Invalid guess. Please enter #{@mastermind.code_maker.CODE_LENGTH} comma-separated colours."
    end
  end
end

# red, yellow, orange, white, green

class Mastermind
  attr_reader :code, :code_maker

  def initialize
    @code_maker = Code_maker.new
    @code = @code_maker.make_code
  end

  def compare_guess(guess)
    a = []
    a += compare_exact(guess,@code)
    compare_partial(a, guess, @code)
  end

  private

  def compare_exact(guess, code)
    code.each_with_index.reduce([]) do |a, (elem, i)|
      guess[i] == elem ? a.push('O') : a.push('X')
    end
  end

  # algorithm taken from my bubble_sort, so could be refactored if I modify my sort to accept predicates
  def compare_partial(a, guess, code)
    code.each_with_index.reduce(a) do |a, (_, i)|
      unless a[i] == 'O'
        j = 0
        while j < code.length
          if guess[i] == code[j]
            a[i] = '?'
          end
          j += 1
        end
      end
      a
    end
  end
end

class Code_maker
  @@CODE_OPTIONS = ['red', 'orange', 'yellow', 'green', 'blue', 'purple', 'black', 'white']
  @@CODE_LENGTH = 5

  def make_code
    code = @@CODE_OPTIONS.sample(@@CODE_LENGTH).uniq # ideally get 5 random elems
    code += @@CODE_OPTIONS.sample(@@CODE_LENGTH - code.size) until code.size == @@CODE_LENGTH # keep adding samples
    code
  end

  def CODE_OPTIONS
    @@CODE_OPTIONS
  end

  def CODE_LENGTH
    @@CODE_LENGTH
  end
end

test = Game.new

test.play
