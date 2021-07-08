class Bird
  def preen
    puts "I am cleaning my feathers."
  end

  def fly
    puts "I am flying."
  end

  class Penguin < Birddef
    def fly
      puts "Sorry, I'd rather swim."
    end
  end