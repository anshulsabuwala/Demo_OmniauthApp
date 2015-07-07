# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150410070639) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.string   "secret",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "username",   limit: 255
  end

  create_table "educations", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "title",          limit: 255
    t.string   "education_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "location",       limit: 255
  end

  create_table "landlords", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "full_name",         limit: 255
    t.string   "gender",            limit: 255
    t.date     "date_of_birth"
    t.string   "address_type",      limit: 255
    t.string   "address",           limit: 255
    t.string   "city",              limit: 255
    t.string   "postal_code",       limit: 255
    t.string   "country",           limit: 255
    t.string   "occupation",        limit: 255
    t.text     "brief_description", limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "user_id",           limit: 4
    t.string   "timezone",          limit: 255
    t.boolean  "verify_properties", limit: 1
    t.string   "phone_number",      limit: 255
    t.string   "link_url",          limit: 255
    t.datetime "updated_time"
    t.boolean  "verified",          limit: 1
  end

  add_index "landlords", ["user_id"], name: "index_landlords_on_user_id", using: :btree

  create_table "managers", force: :cascade do |t|
    t.string   "company_name",                      limit: 255
    t.string   "phone_number",                      limit: 255
    t.string   "street",                            limit: 255
    t.string   "city",                              limit: 255
    t.string   "postal_code",                       limit: 255
    t.string   "state",                             limit: 255
    t.string   "country",                           limit: 255
    t.text     "company_description",               limit: 65535
    t.string   "occupation",                        limit: 255
    t.string   "page_url",                          limit: 255
    t.string   "add_page",                          limit: 255
    t.boolean  "verify_properties",                 limit: 1
    t.boolean  "estate_agent",                      limit: 1
    t.string   "contact_person_full_name",          limit: 255
    t.string   "contact_person_email_address",      limit: 255
    t.string   "contact_person_occupation",         limit: 255
    t.string   "contact_person_phone_number",       limit: 255
    t.string   "contact_person_position",           limit: 255
    t.string   "contact_person_photo",              limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "user_id",                           limit: 4
    t.string   "contact_person_photo_file_name",    limit: 255
    t.string   "contact_person_photo_content_type", limit: 255
    t.integer  "contact_person_photo_file_size",    limit: 4
    t.datetime "contact_person_photo_updated_at"
  end

  add_index "managers", ["user_id"], name: "index_managers_on_user_id", using: :btree

  create_table "tenants", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "full_name",         limit: 255
    t.string   "gender",            limit: 255
    t.date     "date_of_birth"
    t.string   "address_type",      limit: 255
    t.string   "address",           limit: 255
    t.string   "city",              limit: 255
    t.string   "postal_code",       limit: 255
    t.string   "country",           limit: 255
    t.string   "occupation",        limit: 255
    t.text     "brief_description", limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "user_id",           limit: 4
    t.string   "timezone",          limit: 255
    t.string   "phone_number",      limit: 255
    t.string   "link_url",          limit: 255
    t.datetime "updated_time"
    t.boolean  "verified",          limit: 1
  end

  add_index "tenants", ["user_id"], name: "index_tenants_on_user_id", using: :btree

  create_table "user_likes", force: :cascade do |t|
    t.string   "category",     limit: 255
    t.string   "name",         limit: 255
    t.datetime "created_time"
    t.integer  "user_id",      limit: 4
  end

  add_index "user_likes", ["user_id"], name: "index_user_likes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                limit: 4
    t.string   "role_type",              limit: 255
    t.string   "username",               limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "account_type",           limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.boolean  "admin",                  limit: 1
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_type", "role_id"], name: "index_users_on_role_type_and_role_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "work_histories", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "company",    limit: 255
    t.string   "position",   limit: 255
    t.string   "location",   limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "user_likes", "users"
end
