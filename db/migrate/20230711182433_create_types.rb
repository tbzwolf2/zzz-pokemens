class CreateTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :types do |t|
      t.string :name
      t.hstore :damage_relations
      t.timestamps
    end
  end
end
