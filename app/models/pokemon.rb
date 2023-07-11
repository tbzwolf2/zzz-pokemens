class Pokemon < ApplicationRecord
  has_many :type

  def self.find_by_name_or_id(param)
    # Find_by here to prevent an error being thrown by find
    pokemon = Pokemon.find_by(id: param)
    unless pokemon
      pokemon = Pokemon.find_by(name: param)
    end
    pokemon
  end

  # This is causing an n+1 but im unable to find a structure I can make that will preloading of all types on each poke
  def type_details
    type_h = {}
    types.each do |type|
      type_h[type] = Type.select("name, damage_relations").find_by(name: type)
    end
    type_h
  end
end
