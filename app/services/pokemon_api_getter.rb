class PokemonApiGetter
  def initialize()
    get_pokemon()
    get_types()
  end

  def get_types(response = HTTParty.get('https://pokeapi.co/api/v2/type/'))
    response["results"].each do |t|
      create_type(t["url"])
    end
    get_types(HTTParty.get(response["next"])) if response["next"]
  end

  def get_pokemon(response = HTTParty.get('https://pokeapi.co/api/v2/pokemon/'))
    response["results"].each do |p|
      create_pokemon(p["url"])
    end 
    get_pokemon(HTTParty.get(response["next"])) if response["next"]
  end

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
    type_a = []
    response["types"].map{ |h| type_a << h["type"]["name"]}
    
    p = Pokemon.find_or_create_by(
      id: response["id"],
      name: response["name"],
      base_experience: response["base_experience"],
      height: response["height"],
      is_default: response["is_default"],
      order: response["order"],
      weight: response["weight"],
    ) 
    # This causes it to not find duplicates, not quite sure why but must be due to the array
    p.update( types: type_a)
  end
end
