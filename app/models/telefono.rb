class Telefono < ActiveRecord::Base
  validates_presence_of :numero, :tipo
  validates_uniqueness_of :persona_id, :numero, :scope => [:persona_id, :numero]
  validates_numericality_of :numero, :only_integer => true, :message => "debe contener solo números"
  validates_length_of :numero, :minimum => 7, :message => "debe tener al menos 7 dígitos"

  belongs_to :persona
end
