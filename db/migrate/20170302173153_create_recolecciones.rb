class CreateRecolecciones < ActiveRecord::Migration[5.0]
  def change
    create_table :recolecciones do |t|
      t.integer :folio
      t.string :conductor
      t.integer :bruto
      t.integer :tara
      t.integer :neto
      t.date   :fecha_entrada
      t.date   :fecha_salida
      t.string :dia
      t.integer :mes
      t.integer :ano
      t.string :sector
      t.string :zona

      t.belongs_to :contratistas, foreign_key: true
      t.belongs_to :zonas, foreign_key: true
      t.belongs_to :camiones, foreign_key: true


      t.timestamps
    end
  end
end
