class AddCedulaToPersona < ActiveRecord::Migration
  def self.up
    add_column :personas, :cedula, :string
  end

  def self.down
    remove_column :personas, :cedula
  end
end
