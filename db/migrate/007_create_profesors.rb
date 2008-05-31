class CreateProfesors < ActiveRecord::Migration
  def self.up
    #Estos atributos los usa únicamente los profesores que heredan de persona
    add_column :personas, :salario, :integer
  end

  def self.down
    remove_column :personas, :salario
  end
end
