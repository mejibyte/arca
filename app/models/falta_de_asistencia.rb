class FaltaDeAsistencia < ActiveRecord::Base
  validates_presence_of :fecha, :motivo, :persona_id
  validates_uniqueness_of :persona_id, :fecha, :scope => [:persona_id, :fecha]
  belongs_to :persona #En verdad pertenece a un alumno, pero un alumno no tiene su propio alumno_id sino persona_id
  
  def self.search(alumno,campo)
    s = limpiar_string_buscadora(campo)
    @faltas_de_asistencias = FaltaDeAsistencia.find(:all,
                           :conditions => ["persona_id = ? AND LOWER(fecha) LIKE ?",
                                           "#{alumno.id}","%#{s}%"])
  end

  def self.searchAll(campo)
    s = limpiar_string_buscadora(campo)
    @faltas_de_asistencias = FaltaDeAsistencia.find(:all,
                           :conditions => ["LOWER(fecha) LIKE ?",
                                           "%#{s}%"])
  end

  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ -]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
  end

end
