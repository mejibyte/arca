class AddRutaIdToPersona < ActiveRecord::Migration
  def self.up
    add_column :personas, :ruta_id, :integer
  end

  def self.down
   remove_column :personas, :ruta_id
  end
end
