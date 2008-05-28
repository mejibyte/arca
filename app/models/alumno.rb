class Alumno < Persona
  validates_presence_of :fecha_nacimiento, :fecha_ingreso, :cuidados_especiales
end
