class Person
  attr_reader :name, :hitpoint, :attack_damage

  def initialize(name, hitpoint, attack_damage, deflect_chance)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
    @deflect_chance = deflect_chance
  end

  def to_s
    "#{@name} has #{@hitpoint} hitpoint and #{attack_damage} attack_damage."
  end

  def is_dead?
    if @hitpoint <= 0
      puts "#{name} dies."
      return true
    end
  end

  def is_deflecting_attack?
    random_0_to_1 = rand()
    if random_0_to_1 <= @deflect_chance
      puts "#{@name} deflects the attack."
      return true
    end
  end

  def attack(other_person)
    puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage."
    other_person.take_damage(@attack_damage)
  end

  def take_damage(damage)
    if !self.is_deflecting_attack?
      @hitpoint -= damage
    end
  end
end