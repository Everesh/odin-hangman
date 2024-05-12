class Hangman

  ATTEMPTS = 8

  attr_reader :state, :wrong_guesses, :attempts_left

  def initialize
    raise 'Failed to initialize, dictionary.txt does not exist' unless File.exist?('./dictionary.txt')

    dictionary = File.readlines('./dictionary.txt')
    @key = dictionary[rand(dictionary.size)]
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

    found = false
    key.each.with_index do |column, index|
      state[index] = key[index] if column == key[index]
      found = true
    end
    wrong_guesses.push(letter) unless found
    true
  end

  def already_guessed?(letter)
    state.any? == letter || wrong_guesses.any? == letter
  end
end
