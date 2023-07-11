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
end
