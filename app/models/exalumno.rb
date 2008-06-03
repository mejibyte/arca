class Exalumno < ActiveRecord::Base
  validates_presence_of :fecha_retiro
  validates_presence_of :motivo

  belongs_to :alumno, :foreign_key => :persona_id

end
