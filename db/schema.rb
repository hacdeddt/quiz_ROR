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

ActiveRecord::Schema.define(version: 2019_05_27_112214) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "q_option"
    t.integer "user_id"
    t.float "q_score"
    t.integer "result_id"
    t.integer "qbank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qbank_id"], name: "index_answers_on_qbank_id"
    t.index ["result_id"], name: "index_answers_on_result_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delete", default: false, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "ckeditor_assets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "qbanks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "question", null: false
    t.text "optionA", null: false
    t.text "optionB", null: false
    t.text "optionC", null: false
    t.text "optionD", null: false
    t.string "option_match", null: false
    t.text "answer"
    t.string "image"
    t.string "mp3"
    t.boolean "accept", default: false, null: false
    t.string "md5_question"
    t.boolean "is_delete", default: false, null: false
    t.integer "category_id"
    t.integer "subject_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hide_option", default: false
    t.index ["category_id"], name: "index_qbanks_on_category_id"
    t.index ["md5_question"], name: "index_qbanks_on_md5_question", unique: true
    t.index ["question"], name: "question", type: :fulltext
    t.index ["subject_id"], name: "index_qbanks_on_subject_id"
    t.index ["user_id"], name: "index_qbanks_on_user_id"
  end

  create_table "results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "total_time"
    t.float "total_score", default: 0.0
    t.integer "test_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_an_correct", default: 0
    t.boolean "is_delete", default: false, null: false
    t.integer "noq", default: 0
    t.index ["test_id"], name: "index_results_on_test_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delete", default: false, null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "test_qbanks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "qbank_id"
    t.integer "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qbank_id"], name: "index_test_qbanks_on_qbank_id"
    t.index ["test_id"], name: "index_test_qbanks_on_test_id"
  end

  create_table "tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "full_score", null: false
    t.integer "duration", null: false
    t.integer "views", default: 0
    t.integer "category_id"
    t.integer "subject_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "results_count", default: 0
    t.boolean "is_delete", default: false, null: false
    t.index ["category_id"], name: "index_tests_on_category_id"
    t.index ["name", "description"], name: "search_test", type: :fulltext
    t.index ["name"], name: "index_tests_on_name", unique: true
    t.index ["subject_id"], name: "index_tests_on_subject_id"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "fullName"
    t.string "address"
    t.date "year_birthday"
    t.boolean "role", default: false, null: false
    t.string "image"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "banned", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["fullName"], name: "index_users_on_fullName"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
