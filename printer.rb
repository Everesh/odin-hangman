module Printer
  def print_state
    if attempts_left.zero?
      puts 'Loading your doom... ████████████████████ DONE!'
    elsif state.any?(nil)
      puts_loading_bar
    else
      puts 'Noooo, my loading!!! ░░░░░░░░░░░░░░░░░░░░░'
    end
    prints_attpets_left
    puts_wrong_guesses
    if attempts_left.zero?
      key.each { |letter| print " #{letter} " }
      puts
    else
      puts_sate
    end
  end

  private

  def puts_loading_bar
    print 'Loading your doom... '

    case attempts_left * 100 / Hangman::ATTEMPTS
    when 90..100
      print '█░░░░░░░░░░░░░░░░░░░'
    when 80..89
      print '███░░░░░░░░░░░░░░░░░'
    when 70..79
      print '█████░░░░░░░░░░░░░░░'
    when 60..69
      print '███████░░░░░░░░░░░░░'
    when 50..59
      print '█████████░░░░░░░░░░░'
    when 40..49
      print '███████████░░░░░░░░░'
    when 30..39
      print '█████████████░░░░░░░'
    when 20..29
      print '███████████████░░░░░'
    when 10..19
      print '█████████████████░░░'
    when 1..9
      print '███████████████████░'
    end

    puts " #{100 - (attempts_left * 100 / Hangman::ATTEMPTS)}%"
  end

  def prints_attpets_left
    print "Attepts left: #{attempts_left}   "
  end

  def puts_wrong_guesses
    print 'Wrong guesses:'
    wrong_guesses.each { |guess| print " #{guess}" }
    puts
  end

  def puts_sate
    state.each do |letter|
      if letter.nil?
        print ' _ '
      else
        print " #{letter} "
      end
    end
    puts
  end
end
