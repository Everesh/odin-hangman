class Hangman

  ATTEMPTS = 8

  def initialize
    raise 'Failed to initialize, dictionary.txt does not exist' unless File.exist?('./dictionary.txt')

    dictionary = File.readlines('./dictionary.txt')
    @key = dictionary[rand(dictionary.size)]
    @state = Array.new(key.size)
    @wrong_guesses = []
    @attempts_left = ATTEMPTS
  end

  def guess(letter)
    begin
      letter = letter.downcase.chr
      raise StandardError unless letter.match(/[a-z]/)
    rescue StandardError
      raise 'Invalid Input!'
    end
    evaluate(letter)
  end

  private

  attr_reader :key

  attr_accessor :state, :wrong_guesses, :attempts_left
end
