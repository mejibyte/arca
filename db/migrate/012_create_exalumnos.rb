class CreateExalumnos < ActiveRecord::Migration
  def self.up
    create_table :exalumnos do |t|
      t.date :fecha_retiro
      t.text :motivo

      t.timestamps
    end
  end

  def self.down
    drop_table :exalumnos
  end
end
