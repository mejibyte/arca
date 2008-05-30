class Familia < ActiveRecord::Base
  validates_presence_of :codigo
  validates_uniqueness_of :codigo

  has_many :alumno, :dependent => :nullify
end
