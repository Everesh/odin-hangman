class Hangman

  ATTEMPTS = 8

  def initialize
    dictionary = File.readlines('./dictionary.txt')
    @key = dictionary[rand(dictionary.size)]
    @state = Array.new(key.size)
    @wrong_guesses = []
    @attempts_left = ATTEMPTS
  end

  def guess(letter)
    letter = letter.downcase.char
    begin
      raise StandardError unless letter.match(/[a-z]/)
    rescue StandardError
      puts 'Invalid Input!'
      return false
    end
    evaluate(letter)
    true
  end

  private

  attr_reader :key

  attr_accessor :state, :wrong_guesses, :attempts_left
end
