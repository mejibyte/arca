# Maneja las relaciones entre personas/familiares y alumnos
# Ademas maneja el nombre de la familia
class Familia < ActiveRecord::Base
  validates_presence_of :nombre

  has_many :alumnos, :dependent => :nullify
  has_many :personas, :dependent => :nullify

  # Busca las personas/familiares que pertenecen a la familia
  def personas_no_alumno
    personas.find :all, :conditions => { :type => nil },
    :order => "apellidos, nombres ASC"
  end
  
  # Busca familias filtrando por el nombre de la familia
  def self.search(familia)
    s=limpiar_string_buscadora(familia)
    @familias = Familia.find(:all,
                             :conditions => ["LOWER(nombre) LIKE ?",
                                             "%#{s}%"],
                             :order => "nombre ASC")
  end

  # Elimina caracteres no compatibles con la busqueda
  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
   
  end
end
