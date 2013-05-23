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

ActiveRecord::Schema.define(:version => 20130523202226) do

  create_table "admins", :force => true do |t|
    t.string   "email",                             :default => "", :null => false
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aliases", :force => true do |t|
    t.string  "alias_username", :limit => 64, :default => "", :null => false
    t.string  "alias_domain",   :limit => 64, :default => "", :null => false
    t.string  "local_username", :limit => 64, :default => "", :null => false
    t.string  "local_domain",   :limit => 64, :default => "", :null => false
    t.integer "user_id"
    t.integer "domain_id"
  end

  add_index "aliases", ["alias_username", "alias_domain"], :name => "alias_idx", :unique => true
  add_index "aliases", ["local_username", "local_domain"], :name => "target_idx"

  create_table "domain_attrs", :force => true do |t|
    t.string   "did",           :limit => 64,                                    :null => false
    t.string   "name",          :limit => 32,                                    :null => false
    t.integer  "type",                                                           :null => false
    t.string   "value",                                                          :null => false
    t.datetime "last_modified",               :default => '1900-01-01 00:00:01', :null => false
  end

  add_index "domain_attrs", ["did", "name", "value"], :name => "index_domain_attrs_on_did_and_name_and_value", :unique => true

  create_table "domains", :force => true do |t|
    t.string   "domain",        :limit => 64, :default => "",                    :null => false
    t.datetime "last_modified",               :default => '1900-01-01 00:00:01', :null => false
    t.string   "did"
  end

  add_index "domains", ["domain"], :name => "index_domains_on_domain", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.integer  "freeswitch_id"
    t.string   "freeswitch_password"
    t.string   "ha1"
    t.string   "ha1b"
    t.string   "domain"
    t.string   "sip_username"
  end

  create_table "version", :id => false, :force => true do |t|
    t.string  "table_name",    :limit => 32,                :null => false
    t.integer "table_version",               :default => 0, :null => false
  end

end
