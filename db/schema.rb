# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 11) do

  create_table "familias", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nombre"
  end

  create_table "grupos", :force => true do |t|
    t.string   "nombre"
    t.string   "jornada"
    t.integer  "profesor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personas", :force => true do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.text     "direccion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.text     "cuidados_especiales"
    t.date     "fecha_ingreso"
    t.date     "fecha_nacimiento"
    t.string   "cedula"
    t.integer  "familia_id"
    t.integer  "salario"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"
  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "clave_encriptada"
    t.string   "palabra_random"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
