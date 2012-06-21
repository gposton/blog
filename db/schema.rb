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

ActiveRecord::Schema.define(:version => 20120621220352) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.text     "content"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "photos", :force => true do |t|
    t.integer  "user_id",            :limit => 255
    t.boolean  "displaying"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "album_id"
  end

  create_table "player_results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.integer  "buy_in",        :default => 0
    t.integer  "winnings",      :default => 0
    t.integer  "finish",        :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.integer  "buy_in",        :default => 20
    t.integer  "winnings",      :default => 0
    t.integer  "finish",        :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "no_show"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "web_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts_tags", :id => false, :force => true do |t|
    t.integer "post_id", :null => false
    t.integer "tag_id",  :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",          :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "special_access", :default => false
    t.boolean  "poker_player",   :default => false
  end

end
