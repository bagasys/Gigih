require_relative 'person'

class Hero < Person
  def initialize(name, hitpoint, attack_damage)
    super(name, hitpoint, attack_damage)
    @deflect_chance = 0.8
    @healing_point = 20
  end

  def playable?
    return @playable
  end

  def deflect_attack?
    if rand() <= @deflect_chance
      puts "#{@name} deflects the attack."
      return true
    end
  end

  def take_damage(damage)
    if !self.deflect_attack?
      @hitpoint -= damage  
    end
  end

  def heal(other_person)
    puts "#{@name} heals #{other_person.name}, restoring #{@healing_point} hitpoints."
    other_person.take_healing(@healing_point)
  end
end