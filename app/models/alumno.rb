# Alumno hereda persona solo que con otras caracteristicas agregadas
# fecha_nacimiento, fecha_ingreso, cuidados_especiales
class Alumno < Persona
  validates_presence_of :fecha_nacimiento, :fecha_ingreso, :cuidados_especiales
  belongs_to :familia
  belongs_to :grupo
  belongs_to :ruta
  has_one :exalumno, :dependent => :destroy, :foreign_key => :persona_id

  # Busca los alumnos sin familia y permite filtrar por medio de sus nombres y apellidos su busqueda
  def self.alumnos_sin_familia(campo)
    s = limpiar_string_buscadora(campo)
    @alumnos = Alumno.find(:all,
                           :conditions => ["familia_id IS NULL AND LOWER(nombres || apellidos) LIKE ?",
                                           "%#{s}%"],
                           :order => "apellidos, nombres ASC")
  end

  # Busca los alumnos sin grupo y permite filtrar por medio de sus nombres y apellidos su busqueda
  def self.alumnos_sin_grupo(campo)
    s = limpiar_string_buscadora(campo)
    @alumnos = Alumno.find(:all,
                           :conditions => ["grupo_id IS NULL AND LOWER(nombres || apellidos) LIKE ?",
                                           "%#{s}%"],
                           :order => "apellidos, nombres ASC")
    @alumnos.delete_if{ |a| not a.exalumno.nil? }
  end
  
  # Busca alumnos por medio de sus nombres y apellidos
  def self.search(campo)
    s = limpiar_string_buscadora(campo)
    @alumnos = Alumno.find(:all,
                           :conditions => ["LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"],
                           :order => "apellidos, nombres ASC")
  end

  # Elimina los caracteres incompatibles con la busqueda
  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
  end


end
