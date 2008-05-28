class AddInheritedDataOfAlumnoFromPersona < ActiveRecord::Migration
  def self.up
    #Estos atributos los usa únicamente los alumnos que heredan de persona
    add_column :personas, :cuidados_especiales, :text
    add_column :personas, :fecha_ingreso, :date
    add_column :personas, :fecha_nacimiento, :date
  end

  def self.down
    remove_column :personas, :cuidados_especiales
    remove_column :personas, :fecha_ingreso
    remove_column :personas, :fecha_nacimiento
  end
end
