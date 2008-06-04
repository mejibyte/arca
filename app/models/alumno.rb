class Alumno < Persona
  validates_presence_of :fecha_nacimiento, :fecha_ingreso, :cuidados_especiales
  belongs_to :familia
  belongs_to :grupo
  has_one :exalumno, :dependent => :destroy, :foreign_key => :persona_id

  def self.alumnos_sin_familia(campo)
    s = limpiar_string_buscadora(campo)
    @alumnos = Alumno.find(:all,
                           :conditions => ["familia_id IS NULL AND LOWER(nombres || apellidos) LIKE ?","%#{s}%"] )
  end

  def self.alumnos_sin_grupo(campo)
    s = limpiar_string_buscadora(campo)
    @alumnos = Alumno.find(:all,
                           :conditions => ["grupo_id IS NULL AND LOWER(nombres || apellidos) LIKE ?","%#{s}%"] )

    
  end
  def self.search(campo)
    s = limpiar_string_buscadora(campo)
    @alumnos = Alumno.find(:all,
                             :conditions => ["LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"] )
  end
  
  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
  end
  
end
