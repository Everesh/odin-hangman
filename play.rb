require './hangman'

if File.exist?('save.yml')
  puts 'Looks like you have a game saved!'
  begin
    puts 'Do you wish to load it? [N/y]'
    decision = gets.downcase.chr
    raise StandardError unless decision.match(/[y,n,\n]/)
  rescue StandardError
    puts 'Invalid Input!'
    retry
  end
  if decision == 'y'
    Hangman.new(File.read('save.yml')).play
  else
    Hangman.new.play
  end

else
  Hangman.new.play
end
