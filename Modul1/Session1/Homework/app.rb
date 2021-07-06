require_relative 'person'

jin = Person.new('Jin Sakai', 100, 50, 0.8)
puts jin
puts "\n"

khotun = Person.new('Khotun Khan', 500, 50, 0)
puts khotun
puts "\n"

loop do
  jin.attack(khotun)
  puts khotun
  puts "\n"

  break if khotun.is_dead?

  khotun.attack(jin)
  puts jin
  puts "\n"
  
  break if jin.is_dead?
end

