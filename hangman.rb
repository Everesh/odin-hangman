require './printer'
require 'yaml'

class Hangman
  include Printer

  ATTEMPTS = 8

  attr_reader :state, :wrong_guesses, :attempts_left

  def initialize(str = nil)
    if str.nil?
      create
    else
      loaded = YAML.load str
      @key = loaded[:key]
      @state = loaded[:state]
      @wrong_guesses = loaded[:wrong_guesses]
      @attempts_left = loaded[:attempts_left]
    end
  end

  def play
    initialize unless attempts_left.positive?
    print_state
    while attempts_left.positive?
      break unless state.any?(nil)

      print "So, what do we do next?: [Chr/'save'] "
      input = gets.chomp
      if input == 'save'
        save
        return
      else
        guess(input)
      end
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

  def create
    raise 'Failed to initialize, dictionary.txt does not exist' unless File.exist?('./dictionary.txt')

    dictionary = File.readlines('./dictionary.txt')
    word = ''
    word = dictionary[rand(dictionary.size)].chomp until (5..12).include?(word.length)
    @key = word.split('')
    @state = Array.new(key.size)
    @wrong_guesses = []
    @attempts_left = ATTEMPTS
  end

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

  def save
    serialized = YAML.dump({
                             key: key,
                             state: state,
                             wrong_guesses: wrong_guesses,
                             attempts_left: attempts_left
                           })
    File.open('save.yml', 'w') { |f| f.write(serialized) }
  end
end
