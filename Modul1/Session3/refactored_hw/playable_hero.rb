require_relative 'hero'

class PlayableHero < Hero
  def initialize(name, hitpoint, attack_damage)
    super(name, hitpoint, attack_damage)
    @actions = ["attack", "heal"]
  end

  def play_turn(heroes, villains)
    action = select_action
    puts "\n"
    if action == "attack"
      villain = select_target(action, villains)
      self.attack(villain)
    elsif action == "heal"
      hero = select_target(action, heroes)
      self.heal(hero)
    end
  end

  def select_action
    choice = -1
    until choice.between?(1, @actions.size)
      puts "Which action do you want to do?"
        @actions.each.with_index(1) do |action, index|
          puts "#{index} #{action}"
        end
        choice = gets.chomp.to_i
    end
    return @actions[choice - 1]
  end

  def select_target(action, options)
    choice = -1
    until choice.between?(1, options.size)
      puts "Which character do you wan to #{action}?"
        options.each.with_index(1) do |option, index|
          puts "#{index} #{option}"
        end
        choice = gets.chomp.to_i
    end
    return options[choice - 1]
  end
end