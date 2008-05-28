class CreatePersonas < ActiveRecord::Migration
  def self.up
    create_table :personas do |t|
      t.string :nombres
      t.string :apellidos
      t.text :direccion

      t.timestamps
    end
  end

  def self.down
    drop_table :personas
  end
end
