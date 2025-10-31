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

ActiveRecord::Schema[8.0].define(version: 2025_10_31_064259) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "name"
    t.text "body"
    t.text "record_type"
    t.bigint "record_id"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.index ["record_type", "record_id", "name"], name: "idx_16461_index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.text "name"
    t.text "record_type"
    t.bigint "record_id"
    t.bigint "blob_id"
    t.timestamptz "created_at"
    t.bigint "position"
    t.index ["blob_id"], name: "idx_16447_index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "idx_16447_index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.text "key"
    t.text "filename"
    t.text "content_type"
    t.text "metadata"
    t.text "service_name"
    t.bigint "byte_size"
    t.text "checksum"
    t.timestamptz "created_at"
    t.index ["key"], name: "idx_16440_index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id"
    t.text "variation_digest"
    t.index ["blob_id", "variation_digest"], name: "idx_16454_index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.text "name"
    t.text "slug"
    t.bigint "order"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "products_count"
    t.index ["slug"], name: "idx_16409_index_categories_on_slug"
  end

  create_table "pins", force: :cascade do |t|
    t.text "title"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.text "name"
    t.text "slug"
    t.decimal "price", precision: 10, scale: 2
    t.timestamptz "uploaded_at"
    t.bigint "quantity"
    t.text "condition"
    t.bigint "category_id"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "tag"
    t.bigint "status", default: 0
    t.index ["category_id"], name: "idx_16425_index_products_on_category_id"
    t.index ["slug"], name: "idx_16425_index_products_on_slug", unique: true
  end

  create_table "solid_queue_executions", force: :cascade do |t|
    t.bigint "solid_queue_job_id", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solid_queue_job_id"], name: "index_solid_queue_executions_on_solid_queue_job_id"
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments", default: "{}"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "status", default: "queued"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "active_job_id"
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key"
    t.datetime "expires_at"
    t.index ["queue_name"], name: "index_solid_queue_jobs_on_queue_name"
    t.index ["status"], name: "index_solid_queue_jobs_on_status"
  end

  create_table "solid_queue_queues", force: :cascade do |t|
    t.string "name", null: false
    t.integer "job_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "email", default: ""
    t.text "encrypted_password", default: ""
    t.text "reset_password_token"
    t.timestamptz "reset_password_sent_at"
    t.timestamptz "remember_created_at"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.index ["email"], name: "idx_16416_index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "idx_16416_index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id", name: "active_storage_attachments_blob_id_fkey"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id", name: "active_storage_variant_records_blob_id_fkey"
  add_foreign_key "products", "categories", name: "products_category_id_fkey"
  add_foreign_key "solid_queue_executions", "solid_queue_jobs"
end
