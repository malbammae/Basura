class CreateCamiones < ActiveRecord::Migration[5.0]
  def change
    create_table :camiones do |t|

      t.string :patente
      t.string :numero

      t.string :marca
      t.string :modelo
      t.string :caja
      t.string   :ano
      t.belongs_to :contratistas, foreign_key: true

      t.timestamps
    end
  end
end
