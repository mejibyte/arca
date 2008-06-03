class CreateTelefonos < ActiveRecord::Migration
  def self.up
    create_table :telefonos do |t|
      t.references :persona
      t.string :numero

      t.timestamps
    end
  end

  def self.down
    drop_table :telefonos
  end
end
