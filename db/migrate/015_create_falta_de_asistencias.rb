class CreateFaltaDeAsistencias < ActiveRecord::Migration
  def self.up
    create_table :falta_de_asistencias do |t|
      t.date :fecha
      t.text :motivo
      t.references :persona

      t.timestamps
    end
  end

  def self.down
    drop_table :falta_de_asistencias
  end
end
