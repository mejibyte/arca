class CreateTransportadors < ActiveRecord::Migration
  def self.up
    add_column :personas, :tarifa_mensual, :integer
    add_column :personas, :tarifa_individual, :integer
  end

  def self.down
    remove_column :personas, :tarifa_mensual
    remove_column :personas, :tarifa_individual
  end
end
