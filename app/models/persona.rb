class Persona < ActiveRecord::Base
  validates_presence_of :nombres, :apellidos, :direccion, :cedula
  validates_uniqueness_of :cedula

  belongs_to :familia
  has_many :telefonos, :dependent => :destroy
  has_many :falta_de_asistencias, :dependent => :destroy

  def self.personas_sin_familia(persona)
    s = limpiar_string_buscadora(persona)
    @personas = Persona.find(:all,
                             :conditions => ["type IS NULL AND familia_id IS NULL AND LOWER(nombres || apellidos) LIKE ?","%#{s}%"] )
  end

  def nombre_completo
    "#{nombres} #{apellidos}"
  end

  def self.search(campo)
    s = limpiar_string_buscadora(campo)
    @personas = Persona.find(:all,
                             :conditions => ["type IS NULL AND LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"] )
  end

  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
  end
  
end
