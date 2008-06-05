class Exalumno < ActiveRecord::Base
  validates_presence_of :fecha_retiro
  validates_presence_of :motivo

  validates_uniqueness_of :persona_id # Un alumno no se puede retirar dos veces

  belongs_to :alumno, :foreign_key => :persona_id
   

end
