class Profesor < Persona
  validates_presence_of :salario
  has_many :grupos, :dependent => :nullify
end
