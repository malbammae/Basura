class CreateContratistas < ActiveRecord::Migration[5.0]
  def change
    create_table :contratistas do |t|
      t.string :nombre


      t.timestamps
    end
  end
end
