class Hangman

  ATTEMPTS = 8

  def initialize
    dictionary = File.readlines('./dictionary.txt')
    @key = dictionary[rand(dictionary.size)]
    @state = Array.new(key.size)
    @attempts_left = ATTEMPTS
  end

  private

  attr_reader :key
end
