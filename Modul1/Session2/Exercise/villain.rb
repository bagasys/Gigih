require_relative 'person'

class Villain < Person
  def initialize(name, hitpoint, attack_damage)
    super(name, hitpoint, attack_damage)
    @flee_chance = 0.5
    @fled = false
  end

  def take_damage(damage)
    @hitpoint -= damage
    if @hitpoint <= 50
      self.flee if rand < @flee_chance
    end
  end

  def flee
    @fled = true
    puts "#{@name} has fled the battlefield with #{@hitpoint} hitpoint left."
  end

  def flee?
    return @fled
  end
end