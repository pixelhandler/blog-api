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

ActiveRecord::Schema.define(version: 20170604063834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tenant", default: "pixelhandler"
  end

  create_table "commenters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email_hash"
    t.string "tenant", default: "pixelhandler"
    t.index ["email"], name: "index_commenters_on_email", unique: true
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "body"
    t.boolean "approved", default: false
    t.integer "commenter_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tenant", default: "pixelhandler"
    t.index ["commenter_id"], name: "index_comments_on_commenter_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "body"
    t.string "excerpt"
    t.string "slug"
    t.string "title"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.tsvector "tsv"
    t.string "status", default: "pending"
    t.string "tenant", default: "pixelhandler"
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["tsv"], name: "posts_tsv_idx", using: :gin
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "tag_id", null: false
    t.index ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id", unique: true
    t.index ["tag_id", "post_id"], name: "index_posts_tags_on_tag_id_and_post_id", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "tenant", default: "pixelhandler"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tenant", default: "pixelhandler"
  end

  add_foreign_key "comments", "commenters"
  add_foreign_key "comments", "posts"
  add_foreign_key "posts", "authors"
  add_foreign_key "users", "authors"
end
