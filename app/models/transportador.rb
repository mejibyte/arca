class Transportador < Persona
  validates_presence_of :tarifa_mensual, :tarifa_individual
  validates_numericality_of :tarifa_mensual, :tarifa_individual, :integer => true
end
