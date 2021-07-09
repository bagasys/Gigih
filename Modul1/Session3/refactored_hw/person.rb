class Person
  attr_reader :name, :hitpoint, :attack_damage

  def initialize(name, hitpoint, attack_damage)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
  end

  def print_stats
    puts "#{@name} has #{@hitpoint} hitpoint and #{attack_damage} attack_damage."
  end

  def to_s
    @name
  end

  def die?
    if @hitpoint <= 0
      puts "#{name} dies."
      return true
    end
  end

  def attack(other_person)
    puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage."
    other_person.take_damage(@attack_damage)
  end

  def take_damage(damage)
    @hitpoint -= damage
  end

  def take_healing(healing_point)
    @hitpoint += healing_point
  end
end
  