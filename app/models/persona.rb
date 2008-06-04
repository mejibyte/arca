class Persona < ActiveRecord::Base
  validates_presence_of :nombres, :apellidos, :direccion, :cedula
  validates_uniqueness_of :cedula

  belongs_to :familia
  has_many :telefonos, :dependent => :destroy
  has_many :falta_de_asistencias, :dependent => :destroy

  def self.personas_sin_familia
    Persona.find :all, :conditions => { :type => nil, :familia_id => nil}
  end

  def nombre_completo
    "#{nombres} #{apellidos}"
  end

  def self.search(campo)
    campo ||= ""
    s = campo.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
    @personas = Persona.find(:all,
                             :conditions => ["type IS NULL AND LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"] )
  end
end
