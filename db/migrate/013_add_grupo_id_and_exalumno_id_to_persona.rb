class AddGrupoIdAndExalumnoIdToPersona < ActiveRecord::Migration
  def self.up
    add_column :personas, :grupo_id, :integer
    add_column :personas, :exalumno_id, :integer
  end

  def self.down
    remove_column :personas, :grupo_id
    remove_column :personas, :exalumno_id
  end
end
