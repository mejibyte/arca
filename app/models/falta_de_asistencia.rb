class FaltaDeAsistencia < ActiveRecord::Base
  validates_presence_of :fecha, :motivo, :persona_id
  validates_uniqueness_of :persona_id, :fecha, :scope => [:persona_id, :fecha]
  belongs_to :persona #En verdad pertenece a un alumno, pero un alumno no tiene su propio alumno_id sino persona_id
  validates_date :fecha
  def self.search(alumno,campo,campo2)
    s = limpiar_string_buscadora(campo)
    s2 = limpiar_string_buscadora(campo2)
    @faltas_de_asistencias = FaltaDeAsistencia.find(:all,
                           :conditions => ["persona_id = ? AND fecha >= ? AND fecha <= ?",
                                           "#{alumno.id}","#{s}","#{s2}"])
#    @faltas_de_asistencias &= FaltaDeAsistencia.find(:all,
 #                          :conditions => ["persona_id = ? AND fecha <= ?",
  #                                         "{alumno.id}","{s2}"])
  end

  def self.searchAll(campo,campo2)
    s = limpiar_string_buscadora(campo)
    s2= limpiar_string_buscadora(campo2)
    @faltas_de_asistencias = FaltaDeAsistencia.find(:all,
                           :conditions => ["fecha >= ? AND fecha <= ?",
                                           "%#{s}%","#{s2}"])
#     @faltas_de_asistencias &= FaltaDeAsistencia.find(:all,
 #                          :conditions => ["fecha <= ?",
  #                                         "%{s2}%"])

  end

  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "")
  end

end
