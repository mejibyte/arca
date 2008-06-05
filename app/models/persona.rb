# Maneja los datos basicos de las personas
# nombres, apellidos, direccion, cedula
# Y las posibles relaciones si es un profesor, transportador, alumno
class Persona < ActiveRecord::Base
  validates_presence_of :nombres, :apellidos, :direccion, :cedula
  validates_uniqueness_of :cedula

  belongs_to :familia
  has_many :telefonos, :dependent => :destroy
  has_many :falta_de_asistencias, :dependent => :destroy

  # Busca las personas sin familia y permite filtrar por medio de sus nombres y apellidos su busqueda
  def self.personas_sin_familia(persona)
    s = limpiar_string_buscadora(persona)
    @personas = Persona.find(:all,
                             :conditions => ["type IS NULL AND familia_id IS NULL AND LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"],
                             :order => "apellidos, nombres ASC")
  end
  
  # Retorna la concatenacion entre los nombres y apellidos de una persona
  def nombre_completo
    "#{nombres} #{apellidos}"
  end

  # Busca las personas por medio de sus nombres y apellidos
  def self.search(campo)
    s = limpiar_string_buscadora(campo)
    @personas = Persona.find(:all,
                             :conditions => ["type IS NULL AND LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"],
                             :order => "apellidos, nombres ASC")
  end

  # Elimina los caracteres incompatibles con la busqueda
  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
  end
  
end
