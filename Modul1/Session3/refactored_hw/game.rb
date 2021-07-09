class Game
  def initialize(playable_hero)
    @playable_hero = playable_hero
    @heroes = []
    @villains = []
    @turn = 1
  end

  def add_hero(person)
    @heroes << person
  end

  def add_villain(person)
    @villains << person
  end

  def start
    @tart = 1
    until @heroes.empty? || @villains.empty? do
      puts "========== Turn #{@turn} =========="
      puts "\n"

      self.print_character_stats
      self.play_characters_turn
      @turn += 1
    end
  end

  def print_character_stats
    @heroes.each do |hero|
      hero.print_stats
    end
    puts "\n"

    @villains.each do |villain|
      villain.print_stats
    end
    puts "\n"
  end

  def play_characters_turn
    @playable_hero.play_turn(@heroes, @villains)
    puts "\n"
    @heroes.each do |hero|
      villain = @villains[rand(@villains.size)]
      hero.attack(villain)
      @villains.delete(villain) if villain.remove?
      break if @villains.empty?
    end
    puts "\n"


    @villains.each do |villain|
      hero = @heroes[rand(@heroes.size)]
      villain.attack(hero)
      @heroes.delete(hero) if hero.die?
      break if @heroes.empty?
    end
    puts "\n"
  end
end