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

ActiveRecord::Schema.define(version: 20161203091911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.text     "description"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_announcements_on_event_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "new_idea_id"
    t.index ["new_idea_id"], name: "index_comments_on_new_idea_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "committees", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_committees_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "venue"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "committee_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["committee_id"], name: "index_events_on_committee_id", using: :btree
  end

  create_table "new_ideas", force: :cascade do |t|
    t.text     "description"
    t.boolean  "is_closed"
    t.boolean  "restrict_display"
    t.integer  "committee_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.index ["committee_id"], name: "index_new_ideas_on_committee_id", using: :btree
    t.index ["user_id"], name: "index_new_ideas_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "email"
    t.boolean  "is_super_admin"
    t.boolean  "is_master_admin"
    t.boolean  "is_member"
    t.boolean  "has_access"
  end

  create_table "volunteers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "is_approved"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_volunteers_on_event_id", using: :btree
    t.index ["user_id"], name: "index_volunteers_on_user_id", using: :btree
  end

  add_foreign_key "announcements", "events"
  add_foreign_key "comments", "new_ideas"
  add_foreign_key "comments", "users"
  add_foreign_key "committees", "users"
  add_foreign_key "events", "committees"
  add_foreign_key "new_ideas", "committees"
  add_foreign_key "new_ideas", "users"
  add_foreign_key "volunteers", "events"
  add_foreign_key "volunteers", "users"
end
