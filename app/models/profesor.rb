# Profesor hereda de persona y maneja salario y grupos del profesor
class Profesor < Persona
  validates_presence_of :salario
  has_many :grupos, :dependent => :nullify
  
  # Busca profesore por medio de sus nombres y apellidos
  def self.search(profesor)
    s=limpiar_string_buscadora(profesor)
    @profesor = Profesor.find(:all,
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
