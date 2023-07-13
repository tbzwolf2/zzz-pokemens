class CreatePokemonsTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons_types do |t|
      t.integer :pokemon_id
      t.integer :type_id
      t.timestamps
    end
  end
end
