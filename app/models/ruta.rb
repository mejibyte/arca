class Ruta < ActiveRecord::Base

  validates_presence_of :placa_vehiculo, :jornada, :sector
  validates_uniqueness_of :placa_vehiculo, :jornada, :scope => [:placa_vehiculo, :jornada]

  belongs_to :transportador

  before_validation :upcase_placa

  def upcase_placa
    placa_vehiculo.upcase!
  end
end
