class CreateRutas < ActiveRecord::Migration
  def self.up
    create_table :rutas do |t|
      t.string :placa_vehiculo
      t.string :jornada
      t.text :sector
      t.integer :transportador_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rutas
  end
end
