class AddTipoToTelefono < ActiveRecord::Migration
  def self.up
    add_column :telefonos, :tipo, :string
  end

  def self.down
    remove_column :telefonos, :tipo
  end
end
