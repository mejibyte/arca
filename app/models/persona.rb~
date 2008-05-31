class Persona < ActiveRecord::Base
  validates_presence_of :nombres, :apellidos, :direccion, :cedula
  validates_uniqueness_of :cedula
end
