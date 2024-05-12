require './printer'

class Hangman
  include Printer

  ATTEMPTS = 8

  attr_reader :state, :wrong_guesses, :attempts_left

  def initialize
    raise 'Failed to initialize, dictionary.txt does not exist' unless File.exist?('./dictionary.txt')

    dictionary = File.readlines('./dictionary.txt')
    word = ''
    word = dictionary[rand(dictionary.size)].chomp until (5..12).include?(word.length)
    @key = word.split('')
    @state = Array.new(key.size)
    @wrong_guesses = []
    @attempts_left = ATTEMPTS
  end

  def play
    initialize unless attempts_left.positive?
    print_state
    while attempts_left.positive?
      break unless state.any?(nil)

      print 'Soo, what are you thinking?: '
      guess(gets)
      print_state
    end
    if state.any?(nil)
      puts 'Oh wow, you suck at this!'
    else
      puts 'The brain on you. Massive!'
    end
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
      self.attempts_left -= 1
    end
    true
  end

  def already_guessed?(letter)
    state.any?(letter) || wrong_guesses.any?(letter)
  end
end
