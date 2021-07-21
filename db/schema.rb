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

ActiveRecord::Schema.define(version: 2021_07_14_094245) do

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.decimal "rating"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.boolean "isReviewable"
  end

  create_table "comments", force: :cascade do |t|
    t.string "description"
    t.integer "post_id"
    t.integer "user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "director"
    t.decimal "rating"
  end

  create_table "posts", force: :cascade do |t|
    t.string "review"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_posts_on_commentable_type_and_commentable_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "singer"
    t.decimal "rating"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
  end

end
