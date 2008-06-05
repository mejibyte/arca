# Maneja el nombre de los grupos y su jornada
# La relacion estudiantes profesor
class Grupo < ActiveRecord::Base
  validates_presence_of :nombre, :jornada
  validates_uniqueness_of :nombre, :jornada, :scope => [:nombre, :jornada]
  belongs_to :profesor
  has_many :alumnos

  # Busca grupos por medio del nombre del grupo
  def self.search(grupo)
    s=limpiar_string_buscadora(grupo)
    @grupos = Grupo.find(:all,
                         :conditions => ["LOWER(nombre) LIKE ?",
                                         "%#{s}%"],
                         :order => "nombre ASC")
  end
  
  # Retorna la concatenacion entre el nombre del grupo y su jornada
  def nombre_completo
    "#{nombre} (#{jornada})"
  end
  
  # Limpia la string con la que se va buscar de caracteres incompatibles
  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
   
  end
end
