class Exalumno < ActiveRecord::Base
  validates_presence_of :fecha_retiro, :motivo

  has_one :alumno

end
