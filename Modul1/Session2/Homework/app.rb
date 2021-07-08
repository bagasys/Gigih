require_relative 'person'
require_relative 'hero'
require_relative 'mongol_archer'
require_relative 'mongol_spearman'
require_relative 'mongol_swordsman'

jin = Hero.new("Jin Sakai", 100, 50, playable=true)
yuna = Hero.new("Yuna", 90, 45)
ishihara = Hero.new("Sensei Ishihara", 80, 60)
heroes = [jin, yuna, ishihara]


mongol_archer = MongolArcher.new("Mongol Archer", 80, 40)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50)
villains = [mongol_archer, mongol_spearman, mongol_swordsman]

i = 1
until (heroes.empty? || villains.empty?) do
  puts "========== Turn #{i} =========="
  puts "\n"

  heroes.each do |hero|
    puts hero
  end
  puts "\n"
  villains.each do |villain|
    puts villain
  end
  puts "\n"

  heroes.each do |hero|
    if hero.playable?
      action_choice = -1
      until [1, 2].include? action_choice do
        puts "As #{hero.name}, what do you want to do this turn?"
        puts "1) Attack an enemy."
        puts "2) Heal an ally."
        action_choice = gets.chomp.to_i
      end

      if action_choice == 1
        enemy_choice = -1
        until enemy_choice.between?(1, villains.size) do
          puts "As #{hero.name}, which enemy do you want to attack?"
          villains.each.with_index(1) do |villain, index|
            puts "#{index}) #{villain.name}"
          end
          enemy_choice = gets.chomp.to_i
        end
        villain = villains[enemy_choice - 1]
        hero.attack(villain)
        villains.delete(villain) if villain.die? || villain.flee?
        break if villains.empty?
      end

      if action_choice == 2
        ally_choice = -1
        allies = heroes.filter {|ally| ally != hero}
        until ally_choice.between?(1, allies.size) do
          puts "As #{hero.name}, which ally do you want to heal?"
          allies.each.with_index(1) do |ally, index|
            puts "#{index}) #{ally.name}"
          end
          ally_choice = gets.chomp.to_i
        end
        ally = allies[ally_choice - 1]
        hero.heal(ally)
      end
    else
      villain = villains[rand(villains.size)]
      hero.attack(villain)
      villains.delete(villain) if villain.die? || villain.flee?
      break if villains.empty?
    end
  end
  puts "\n"

  villains.each do |villain|
    hero = heroes[rand(heroes.size)]
    villain.attack(hero)
    heroes.delete(hero) if hero.die?
    break if heroes.empty?
  end
  puts "\n"

  i += 1
end