class AddFamiliaIdToAlumno < ActiveRecord::Migration
  def self.up
    #Foreign key de la única familia de un alumno
    add_column :personas, :familia_id, :integer
  end

  def self.down
    remove_column :personas, :familia_id
  end

end
