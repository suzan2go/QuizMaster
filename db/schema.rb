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

ActiveRecord::Schema.define(version: 20170319150842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quiz_question_answers", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.text     "content",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_quiz_question_answers_on_question_id", unique: true, using: :btree
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.integer  "quiz_id",    null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id", using: :btree
  end

  create_table "quiz_trial_user_answers", force: :cascade do |t|
    t.integer  "quiz_trial_id",                 null: false
    t.integer  "question_id",                   null: false
    t.string   "content",                       null: false
    t.boolean  "correct",       default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["question_id"], name: "index_quiz_trial_user_answers_on_question_id", using: :btree
    t.index ["quiz_trial_id", "question_id"], name: "index_quiz_trial_user_answers_on_quiz_trial_id_and_question_id", unique: true, using: :btree
    t.index ["quiz_trial_id"], name: "index_quiz_trial_user_answers_on_quiz_trial_id", using: :btree
  end

  create_table "quiz_trials", force: :cascade do |t|
    t.integer  "quiz_id",                 null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "finished_at"
    t.integer  "status",      default: 0, null: false
    t.index ["quiz_id"], name: "index_quiz_trials_on_quiz_id", using: :btree
    t.index ["user_id"], name: "index_quiz_trials_on_user_id", using: :btree
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_quizzes_on_user_id", using: :btree
  end

  create_table "user_social_profiles", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "provider",      null: false
    t.string   "uid",           null: false
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "description"
    t.string   "image_url"
    t.json     "auth_dump"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["provider", "uid"], name: "index_user_social_profiles_on_provider_and_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_social_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "image_url",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
  end

  add_foreign_key "quiz_question_answers", "quiz_questions", column: "question_id"
  add_foreign_key "quiz_questions", "quizzes"
  add_foreign_key "quiz_trial_user_answers", "quiz_questions", column: "question_id"
  add_foreign_key "quiz_trial_user_answers", "quiz_trials"
  add_foreign_key "quiz_trials", "quizzes"
  add_foreign_key "quiz_trials", "users"
  add_foreign_key "quizzes", "users"
  add_foreign_key "user_social_profiles", "users"
end
