class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :slug
      t.string :aka
      t.string :eg

      t.timestamps
    end
  end
end
