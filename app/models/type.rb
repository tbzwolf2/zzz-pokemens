class Type < ApplicationRecord
  has_many :pokemons_types
  has_many :pokemon, :through => :pokemons_types
end
