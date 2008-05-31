require 'digest/sha1'
class Usuario < ActiveRecord::Base
  validates_presence_of           :nombre
  validates_uniqueness_of         :nombre
  attr_accessor :confirmacion_clave
  validates_confirmation_of :clave
  def validate
    errors.add_to_base("Falta clave" ) if clave_encriptada.blank?
  end
  def self.authenticate(nombre,clave)
    usuario = self.find_by_nombre(nombre)
    if usuario
      clave_experada = encriptar_clave(clave, usuario.palabra_random)
      if usuario.clave_encriptada != clave_experada
         usuario = nil
      end
    end
    usuario
  end
  # 'clave' es un atributo virtual
  def clave
    @clave
  end
  def clave=(pwd)
    @clave = pwd
    return if pwd.blank?
    create_new_palabra_random
    self.clave_encriptada = Usuario.encriptar_clave(self.clave, self.palabra_random)
  end
  def after_destroy
    if Usuario.count.zero?
      raise "No se puede borrar el ultimo usuario"
    end
  end
private
  def create_new_palabra_random
    self.palabra_random = self.object_id.to_s + rand.to_s
  end
  def self.encriptar_clave(clave, palabra_random)
    string_to_hash = clave + "wibble" + palabra_random
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
