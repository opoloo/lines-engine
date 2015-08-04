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

ActiveRecord::Schema.define(version: 20150421093311) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "lines_articles", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "sub_title",        limit: 255
    t.text     "content",          limit: 65535
    t.boolean  "published",                      default: false
    t.datetime "published_at"
    t.string   "hero_image",       limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "slug",             limit: 255
    t.string   "gplus_url",        limit: 255
    t.boolean  "featured",                       default: false
    t.string   "document",         limit: 255
    t.string   "short_hero_image", limit: 255
    t.text     "teaser",           limit: 65535
  end

  add_index "lines_articles", ["slug"], name: "index_lines_articles_on_slug", unique: true, using: :btree

  create_table "lines_authorables", force: :cascade do |t|
    t.integer  "author_id",  limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "lines_authorables", ["article_id"], name: "index_lines_authorables_on_article_id", using: :btree
  add_index "lines_authorables", ["author_id"], name: "index_lines_authorables_on_author_id", using: :btree

  create_table "lines_authors", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "email",         limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "description",   limit: 65535
    t.string   "gplus_profile", limit: 255
  end

  create_table "lines_pictures", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.string   "name",       limit: 255
    t.integer  "article_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "lines_pictures", ["article_id"], name: "index_lines_pictures_on_article_id", using: :btree

  create_table "lines_users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "reset_digest",    limit: 255
    t.datetime "reset_sent_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
