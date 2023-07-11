class ChangeIntToStrTypes < ActiveRecord::Migration[7.0]
  def change
    change_column :pokemons, :types, :string, array: true, default: []
  end
end
