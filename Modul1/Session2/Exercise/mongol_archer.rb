require_relative 'villain'

class MongolArcher < Villain
  def attack(other_person)
    puts "#{@name} shoots an arrow at #{other_person.name} with #{@attack_damage} damage"
    other_person.take_damage(@attack_damage)
  end
end