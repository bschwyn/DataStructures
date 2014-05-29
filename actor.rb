class Actor
	attr_accessor :name, :age, :sex, :birth_date, :birthplace, :filmography
end

an_actor = Actor.new
an_actor.name = "Paul Newman"
an_actor.age = 83
an_actor.filmography = ["Cool Hand Luke", "Butch Cassidy and the Sundance Kid"]

puts an_actor.inspect

class Actress < Actor
end

an_actress = Actress.new
an_actor.name = "Catherine Keener"
an_actress.age = 52
an_actress.filmography = ["Being John malkovich", "Capote"]

puts an_actress.inspect

#Why does the name not show up????