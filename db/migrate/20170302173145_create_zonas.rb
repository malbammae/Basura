class CreateZonas < ActiveRecord::Migration[5.0]
  def change
    create_table :zonas do |t|

      t.string :zona
      t.st_polygon :area, geographic: true
      t.boolean :lunes ,:default =>  false
      t.boolean :martes ,:default =>  false
      t.boolean :miercoles ,:default =>  false
      t.boolean :jueves ,:default =>  false
      t.boolean :viernes ,:default =>  false
      t.boolean :sabado ,:default =>  false
      t.boolean :domingo ,:default =>  false
      t.belongs_to :contratistas, foreign_key: true


      t.timestamps
    end
  end
end
