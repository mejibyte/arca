class Grupo < ActiveRecord::Base
  validates_presence_of :nombre, :jornada
  belongs_to :profesor

  def nombre_completo
    "#{nombre} (#{jornada})"
  end
end
