# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_06_002119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_graphql"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "pgjwt"
  enable_extension "pgsodium"
  enable_extension "plpgsql"
  enable_extension "supabase_vault"
  enable_extension "uuid-ossp"
  enable_extension "vector"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "aal_level", ["aal1", "aal2", "aal3"]
  create_enum "code_challenge_method", ["s256", "plain"]
  create_enum "factor_status", ["unverified", "verified"]
  create_enum "factor_type", ["totp", "webauthn"]
  create_enum "key_status", ["default", "valid", "invalid", "expired"]
  create_enum "key_type", ["aead-ietf", "aead-det", "hmacsha512", "hmacsha256", "auth", "shorthash", "generichash", "kdf", "secretbox", "secretstream", "stream_xchacha20"]

  create_table "documents", id: :integer, default: nil, force: :cascade do |t|
    t.text "content"
    t.vector "vectors", limit: 1536
    t.text "namespace"
  end

  create_table "highlights", force: :cascade do |t|
    t.text "highlight"
    t.text "book_title"
    t.text "book_author"
    t.text "amazon_book_id"
    t.text "note"
    t.text "color"
    t.text "tags"
    t.text "location_type"
    t.float "location"
    t.timestamptz "highlighted_at"
    t.text "document_tags"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id"
    t.vector "vectors", limit: 1536
    t.text "content"
    t.text "namespace"
    t.index ["user_id"], name: "idx_28728_index_highlights_on_user_id"
  end

  create_table "prompts", force: :cascade do |t|
    t.text "input"
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_prompts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email", default: ""
    t.text "encrypted_password", default: ""
    t.text "reset_password_token"
    t.timestamptz "reset_password_sent_at"
    t.timestamptz "remember_created_at"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.boolean "admin"
    t.index ["email"], name: "idx_28720_index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "idx_28720_index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "highlights", "users", name: "highlights_user_id_fkey"
  add_foreign_key "prompts", "users"
end
