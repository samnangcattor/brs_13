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

ActiveRecord::Schema.define(version: 20150621115238) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "target_id",    limit: 4
    t.string   "state_target", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "author_books", force: :cascade do |t|
    t.integer  "book_id",    limit: 4
    t.integer  "author_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "author_books", ["author_id"], name: "index_author_books_on_author_id", using: :btree
  add_index "author_books", ["book_id"], name: "index_author_books_on_book_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "book_categories", force: :cascade do |t|
    t.integer  "book_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "book_categories", ["book_id"], name: "index_book_categories_on_book_id", using: :btree
  add_index "book_categories", ["category_id"], name: "index_book_categories_on_category_id", using: :btree

  create_table "book_states", force: :cascade do |t|
    t.integer  "book_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "state",      limit: 255, default: "unread"
    t.boolean  "favorite",   limit: 1,   default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "book_states", ["book_id"], name: "index_book_states_on_book_id", using: :btree
  add_index "book_states", ["user_id"], name: "index_book_states_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.date     "publish_date"
    t.integer  "page",         limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "review_id",  limit: 4
    t.string   "comment",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "comments", ["review_id"], name: "index_comments_on_review_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "activity_id", limit: 4
    t.boolean  "like",        limit: 1, default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "likes", ["activity_id"], name: "index_likes_on_activity_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "request_books", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "decription", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "request_books", ["user_id"], name: "index_request_books_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "book_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "review",     limit: 255
    t.integer  "rate",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "role",                limit: 4,   default: 0
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "encrypted_password",  limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  limit: 255
    t.string   "last_sign_in_ip",     limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "activities", "users"
  add_foreign_key "author_books", "authors"
  add_foreign_key "author_books", "books"
  add_foreign_key "book_categories", "books"
  add_foreign_key "book_categories", "categories"
  add_foreign_key "book_states", "books"
  add_foreign_key "book_states", "users"
  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "activities"
  add_foreign_key "likes", "users"
  add_foreign_key "request_books", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
