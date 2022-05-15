class CreatePairs < ActiveRecord::Migration[6.1]
  def change
    create_table :pairs do |t|
      t.references :ingredient1, foreign_key: { to_table: 'ingredients' }
      t.references :ingredient2, foreign_key: { to_table: 'ingredients' }
      t.string :slug, null: false

      t.timestamps
    end
  end
end
