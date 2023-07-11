class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string  :name
      t.integer :base_experience
      t.boolean :is_default
      t.integer :height
      t.integer :order
      t.integer :weight
      t.integer :types, array: true, default: [] 

      t.timestamps
    end
  end
end
