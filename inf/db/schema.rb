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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121215042039) do

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "user_id"
    t.text     "about"
    t.string   "personal_link"
    t.string   "nick",                :default => "nick"
    t.integer  "semester_year"
    t.integer  "semester_sem"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "people_projects", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "project_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "person_id"
    t.integer  "course_id",          :default => 1
    t.integer  "semester_year"
    t.integer  "semester_sem"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "downloadCount",      :default => 0
  end

  add_index "projects", ["person_id"], :name => "index_projects_on_person_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "tag_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "person_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
