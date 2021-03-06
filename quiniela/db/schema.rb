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

ActiveRecord::Schema.define(version: 2018_06_08_230725) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "equipos", force: :cascade do |t|
    t.string "codigo"
    t.string "nombre"
    t.integer "idGrupo"
    t.integer "puntos"
    t.integer "partidosJugados"
    t.integer "partidosGanados"
    t.integer "partidosEmpatados"
    t.integer "partidosPerdidos"
    t.integer "golesFavor"
    t.integer "golesContra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipoxusuarios", force: :cascade do |t|
    t.integer "idUsuario"
    t.integer "idEquipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "juegos", force: :cascade do |t|
    t.string "nombre"
    t.integer "participantes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "idPropietario"
    t.integer "monto"
    t.string "codigo"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "equipo1"
    t.integer "equipo2"
    t.integer "resultado"
    t.integer "golesEquipo1"
    t.integer "golesEquipo2"
    t.string "fecha"
    t.string "lugar"
    t.integer "finalizado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partidos", force: :cascade do |t|
    t.string "equipo1"
    t.string "equipo2"
    t.integer "resultado"
    t.integer "golesEquipo1"
    t.integer "golesEquipo2"
    t.string "fecha"
    t.string "lugar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resultado_juegos", force: :cascade do |t|
    t.integer "idUsuario"
    t.integer "idJuego"
    t.integer "idPartido"
    t.integer "prediccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "email"
    t.string "contrasena"
    t.string "foto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token"
    t.integer "equipo"
  end

  create_table "usuarioxjuegos", force: :cascade do |t|
    t.integer "idUsuario"
    t.integer "idJuego"
    t.integer "aciertos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
