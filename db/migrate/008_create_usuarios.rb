class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :nombre
      t.string :clave_encriptada
      t.string :palabra_random

      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
