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

ActiveRecord::Schema.define(version: 20160224210552) do

  create_table "comment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "comment_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "comment_anc_desc_udx", unique: true
  add_index "comment_hierarchies", ["descendant_id"], name: "comment_desc_idx"

  create_table "comments", force: :cascade do |t|
    t.integer  "directive_id"
    t.text     "function"
    t.text     "content"
    t.integer  "parent_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["directive_id"], name: "index_comments_on_directive_id"

  create_table "directives", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "type"
    t.boolean  "editable",   default: true
    t.boolean  "claim",      default: false
    t.boolean  "public",     default: false
    t.integer  "quality"
    t.string   "status",     default: "Draft"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "picture"
  end

  create_table "directives_tags", force: :cascade do |t|
    t.integer "directive_id"
    t.integer "tag_id"
  end

  add_index "directives_tags", ["tag_id", "directive_id"], name: "index_directives_tags_on_tag_id_and_directive_id", unique: true

  create_table "directives_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "directive_id"
    t.string  "type"
  end

  add_index "directives_users", ["user_id", "directive_id"], name: "index_directives_users_on_user_id_and_directive_id"

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type"

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"

  create_table "manages", force: :cascade do |t|
    t.integer "delegate_id"
    t.integer "crisis_id"
  end

  add_index "manages", ["delegate_id", "crisis_id"], name: "index_manages_on_delegate_id_and_crisis_id", unique: true

  create_table "tags", force: :cascade do |t|
    t.string "tag"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "committee"
    t.string   "position"
    t.text     "maps"
    t.string   "email"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "type"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
