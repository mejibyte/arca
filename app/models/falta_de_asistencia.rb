class FaltaDeAsistencia < ActiveRecord::Base
  validates_presence_of :fecha, :motivo
  belongs_to :persona #En verdad pertenece a un alumno, pero un alumno no tiene su propio alumno_id sino persona_id

end
