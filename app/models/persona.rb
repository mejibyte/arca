class Persona < ActiveRecord::Base
  validates_presence_of :nombres, :apellidos, :direccion
end
