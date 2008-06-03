class Exalumno < ActiveRecord::Base
  validates_presence_of :fecha_retiro
  validates_presence_of :motivo

  has_one :alumno

end
