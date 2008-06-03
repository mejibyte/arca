class FaltaDeAsistencia < ActiveRecord::Base
  validates_presence_of :fecha, :motivo, :persona_id
  validates_uniqueness_of :persona_id, :fecha, :scope => [:persona_id, :fecha]
  belongs_to :persona #En verdad pertenece a un alumno, pero un alumno no tiene su propio alumno_id sino persona_id

end
