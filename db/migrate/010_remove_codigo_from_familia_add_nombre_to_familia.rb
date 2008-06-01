class RemoveCodigoFromFamiliaAddNombreToFamilia < ActiveRecord::Migration
  def self.up
    remove_column :familias, :codigo
    add_column :familias, :nombre, :string
  end

  def self.down
    add_column :familias, :codigo, :string
    remove_column :familias, :nombre

  end
end
