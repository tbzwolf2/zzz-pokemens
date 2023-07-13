class PokemonApiGetter
  def initialize()
    get_types()
    get_pokemon()
  end

  def get_types(response = HTTParty.get('https://pokeapi.co/api/v2/type/?limit=100'))
    response["results"].each do |t|
      create_type(t["url"])
    end
    get_types(HTTParty.get(response["next"])) if response["next"]
  end

  def get_pokemon(response = HTTParty.get('https://pokeapi.co/api/v2/pokemon/?limit=100'))
    response["results"].each do |p|
      create_pokemon(p["url"])
    end 
    get_pokemon(HTTParty.get(response["next"])) if response["next"]
  end

  # These create methods could maybe be on the models but being that they only call the api and then create it would needlessly
  # add api detail into the model
  def create_type(url)
    response = HTTParty.get(url)
    Type.find_or_create_by(
      id: response["id"],
      name: response["name"],
      damage_relations: response["damage_relations"]
    )
  end

  def create_pokemon(url)
    response = HTTParty.get(url)

    # String fun to get the id of type rather than searching for name in db
    type_a = []
    response["types"].map{ |h| 
      count= 2
      str= ""
      url =  h["type"]["url"]
      while url[-count] != "/"
        str.prepend(url[-count])
        count+= 1
      end
        type_a << str
    }
    
    poke = Pokemon.find_or_create_by(
      id: response["id"],
      name: response["name"],
      base_experience: response["base_experience"],
      height: response["height"],
      is_default: response["is_default"],
      order: response["order"],
      weight: response["weight"],
    ) 

    type_a.each do |type|
      PokemonsType.create(
        pokemon_id: poke.id,
        type_id: type
      )
    end
  end
end
