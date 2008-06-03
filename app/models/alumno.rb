class Alumno < Persona
  validates_presence_of :fecha_nacimiento, :fecha_ingreso, :cuidados_especiales
  belongs_to :familia
  belongs_to :exalumno
  belongs_to :grupo

  def self.alumnos_sin_familia
    Alumno.find_all_by_familia_id(nil, :order => "apellidos ASC")
  end

  def self.alumnos_sin_grupo
    Alumno.find_all_by_grupo_id(nil, :order => "apellidos ASC")
  end
end
