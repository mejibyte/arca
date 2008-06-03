class Persona < ActiveRecord::Base
  validates_presence_of :nombres, :apellidos, :direccion, :cedula
  validates_uniqueness_of :cedula

  belongs_to :familia

  def self.personas_sin_familia
    Persona.find :all, :conditions => { :type => nil, :familia_id => nil}
  end

  def nombre_completo
    "#{nombres} #{apellidos}"
  end
end
