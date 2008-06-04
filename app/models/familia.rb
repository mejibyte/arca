class Familia < ActiveRecord::Base
  validates_presence_of :nombre

  has_many :alumnos, :dependent => :nullify
  has_many :personas, :dependent => :nullify

  def personas_no_alumno
    personas.find :all, :conditions => { :type => nil }
  end
  
  def self.search(familia)
    s=limpiar_string_buscadora(familia)
    @familias = Familia.find(:all,
                             :conditions => ["LOWER(nombre) LIKE ?",
                                             "%#{s}%"] )
  end

  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
   
  end
end
