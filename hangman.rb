class Hangman

  ATTEMPTS = 8

  attr_reader :state, :wrong_guesses, :attempts_left

  def initialize
    raise 'Failed to initialize, dictionary.txt does not exist' unless File.exist?('./dictionary.txt')

    dictionary = File.readlines('./dictionary.txt')
    @key = dictionary[rand(dictionary.size)].chomp.split('')
    @state = Array.new(key.size)
    @wrong_guesses = []
    @attempts_left = ATTEMPTS
  end

  def guess(str)
    begin
      letter = str.downcase.chr
      raise StandardError unless letter.match(/[a-z]/)
    rescue StandardError
      raise 'Invalid Input!'
    end
    evaluate(letter)
  end

  private

  attr_reader :key

  attr_writer :state, :wrong_guesses, :attempts_left

  def evaluate(letter)
    return false if already_guessed?(letter) || attempts_left < 1

    if key.any?(letter)
      key.each.with_index { |column, index| state[index] = letter if column == letter }
    else
      wrong_guesses.push(letter)
    end
    self.attempts_left -= 1
    true
  end

  def already_guessed?(letter)
    state.any? == letter || wrong_guesses.any? == letter
  end
end