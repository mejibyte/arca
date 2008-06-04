class Grupo < ActiveRecord::Base
  validates_presence_of :nombre, :jornada
  validates_uniqueness_of :nombre, :jornada, :scope => [:nombre, :jornada]
  belongs_to :profesor
  has_many :alumnos
  
  def self.search(grupo)
    s=limpiar_string_buscadora(grupo)
    @grupos = Grupo.find(:all,
                             :conditions => ["LOWER(nombre) LIKE ?",
                                             "%#{s}%"] )
  end
  def nombre_completo
    "#{nombre} (#{jornada})"
  end
  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
   
  end
end
