class AddTypeToPersona < ActiveRecord::Migration
  def self.up
    add_column :personas, :type, :string
  end

  def self.down
    remove_column :personas, :type
  end
end
