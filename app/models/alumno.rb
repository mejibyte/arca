class Alumno < Persona
  validates_presence_of :fecha_nacimiento, :fecha_ingreso, :cuidados_especiales
  belongs_to :familia
  belongs_to :grupo
  has_one :exalumno, :dependent => :destroy, :foreign_key => :persona_id

  def self.alumnos_sin_familia
    Alumno.find_all_by_familia_id(nil, :order => "apellidos ASC")
  end

  def self.alumnos_sin_grupo
    Alumno.find_all_by_grupo_id(nil, :order => "apellidos ASC")
  end
  def self.search(campo)
    campo ||= ""
    s = campo.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
    @alumnos = Alumno.find(:all,
                             :conditions => ["LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"] )

  end
  
end
