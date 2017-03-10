# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170303151921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "camiones", force: :cascade do |t|
    t.string   "patente"
    t.string   "numero"
    t.string   "marca"
    t.string   "modelo"
    t.string   "caja"
    t.string   "ano"
    t.integer  "contratistas_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["contratistas_id"], name: "index_camiones_on_contratistas_id", using: :btree
  end

  create_table "contratistas", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recolecciones", force: :cascade do |t|
    t.integer  "folio"
    t.string   "conductor"
    t.integer  "bruto"
    t.integer  "tara"
    t.integer  "neto"
    t.date     "fecha_entrada"
    t.date     "fecha_salida"
    t.string   "dia"
    t.integer  "mes"
    t.integer  "ano"
    t.string   "sector"
    t.string   "zona"
    t.integer  "contratistas_id"
    t.integer  "zonas_id"
    t.integer  "camiones_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["camiones_id"], name: "index_recolecciones_on_camiones_id", using: :btree
    t.index ["contratistas_id"], name: "index_recolecciones_on_contratistas_id", using: :btree
    t.index ["zonas_id"], name: "index_recolecciones_on_zonas_id", using: :btree
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "rut"
    t.string   "email"
    t.string   "passwd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zonas", force: :cascade do |t|
    t.string    "zona"
    t.geography "area",            limit: {:srid=>4326, :type=>"polygon", :geographic=>true}
    t.boolean   "lunes",                                                                      default: false
    t.boolean   "martes",                                                                     default: false
    t.boolean   "miercoles",                                                                  default: false
    t.boolean   "jueves",                                                                     default: false
    t.boolean   "viernes",                                                                    default: false
    t.boolean   "sabado",                                                                     default: false
    t.boolean   "domingo",                                                                    default: false
    t.integer   "contratistas_id"
    t.datetime  "created_at",                                                                                 null: false
    t.datetime  "updated_at",                                                                                 null: false
    t.index ["contratistas_id"], name: "index_zonas_on_contratistas_id", using: :btree
  end

  add_foreign_key "camiones", "contratistas", column: "contratistas_id"
  add_foreign_key "recolecciones", "camiones", column: "camiones_id"
  add_foreign_key "recolecciones", "contratistas", column: "contratistas_id"
  add_foreign_key "recolecciones", "zonas", column: "zonas_id"
  add_foreign_key "zonas", "contratistas", column: "contratistas_id"
end
