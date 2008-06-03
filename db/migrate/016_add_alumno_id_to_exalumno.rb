class AddAlumnoIdToExalumno < ActiveRecord::Migration
  def self.up
    remove_column  :personas, :exalumno_id
    add_column :exalumnos, :persona_id, :integer

  end

  def self.down
    add_column :personas, :exalumno_id, :integer
    remove_column :exalumnos, :persona_id
  end
end
