# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_06_08_034533) do

  create_table "activity_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_id"
    t.string "targetable_type"
    t.bigint "targetable_id"
    t.string "action"
    t.string "method"
    t.string "route"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["targetable_type", "targetable_id"], name: "index_activity_logs_on_targetable_type_and_targetable_id"
  end

  create_table "balance_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.decimal "credit", precision: 30
    t.decimal "debit", precision: 30
    t.integer "originator_id"
    t.string "originator_type"
    t.text "notes"
    t.text "description"
    t.bigint "balance_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "prev_balance", precision: 30, default: "0"
    t.decimal "curr_balance", precision: 30, default: "0"
    t.index ["balance_id"], name: "index_balance_histories_on_balance_id"
  end

  create_table "balance_ledgers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "partner_id", null: false
    t.bigint "balance_id", null: false
    t.integer "last_bh_id"
    t.timestamp "last_update"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "last_balance", precision: 30
    t.index ["balance_id"], name: "index_balance_ledgers_on_balance_id"
    t.index ["partner_id"], name: "index_balance_ledgers_on_partner_id"
  end

  create_table "balances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "currency"
    t.decimal "balance", precision: 30
    t.decimal "available_balance", precision: 10
    t.boolean "is_active", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "partner_id"
    t.boolean "is_unlimited", default: false
    t.string "name", default: "MAIN_WALLET"
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "bank_account_numbers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank_name"
    t.string "account_number"
    t.string "account_name"
    t.datetime "validate_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "partner_validate", default: "Iris"
    t.index ["account_number"], name: "index_bank_account_numbers_on_account_number"
    t.index ["bank_name"], name: "index_bank_account_numbers_on_bank_name"
  end

  create_table "batch_direct_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "reference_id"
    t.string "transaction_type"
    t.string "currency"
    t.float "amount"
    t.float "amount_limit_per_trx"
    t.string "bank_account_number"
    t.integer "bank_id"
    t.text "sender"
    t.text "recipient"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state"
    t.string "document_reference_number"
    t.string "purpose_of_remittance"
    t.datetime "expiration_date"
    t.integer "single_transaction_length"
  end

  create_table "beneficiary_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "callback_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "transaction_id"
    t.text "payload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "logging_type", default: "callback"
    t.string "logging_action"
    t.index ["logging_type"], name: "index_callback_histories_on_logging_type"
    t.index ["transaction_id"], name: "index_callback_histories_on_transaction_id"
  end

  create_table "card_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "partner_id"
    t.string "reference_number"
    t.string "partner_transaction_id"
    t.string "transaction_type"
    t.string "card_hash_id"
    t.string "currency"
    t.decimal "amount", precision: 10
    t.string "auth_currency"
    t.decimal "auth_amount", precision: 30, scale: 4
    t.string "transaction_currency"
    t.decimal "transaction_amount", precision: 30, scale: 4
    t.string "billing_currency"
    t.decimal "billing_amount", precision: 10
    t.string "state"
    t.date "date"
    t.text "payload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "rate", precision: 19, scale: 9
    t.string "settlement_status", default: "unsettled"
    t.datetime "settlement_date"
    t.integer "settlement_reference_id"
    t.string "original_transaction_id"
  end

  create_table "compliance_lists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "account_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "iso"
    t.string "name"
    t.string "iso_3"
    t.string "iso_name"
    t.integer "numcode"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "transaction_types", default: "---\n- C2C\n"
  end

  create_table "delayed_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "destination_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flexible_validations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "destination"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "idempotent_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "idempotency_key"
    t.bigint "partner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["idempotency_key"], name: "index_idempotent_requests_on_idempotency_key"
    t.index ["partner_id"], name: "index_idempotent_requests_on_partner_id"
  end

  create_table "journal_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 10
    t.date "date"
    t.integer "partner_id"
    t.integer "balance_id"
    t.string "trx_type"
    t.text "description"
    t.text "notes"
    t.boolean "is_debit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "oauth_access_grants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id"
    t.string "owner_type"
    t.text "pub_key", size: :long
    t.boolean "is_va", default: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "partner_balances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.decimal "balance", precision: 30
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partner_special_routes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "partner_id", null: false
    t.bigint "payer_id", null: false
    t.string "best_route"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_partner_special_routes_on_partner_id"
    t.index ["payer_id"], name: "index_partner_special_routes_on_payer_id"
  end

  create_table "partners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "email_pic"
    t.integer "api_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_b2b_partner", default: false
    t.boolean "on_hold", default: false
    t.string "partner_destination"
    t.string "on_behalf"
    t.boolean "generate_pdf", default: false
    t.boolean "special_route_activated", default: true
    t.boolean "has_alert", default: false
  end

  create_table "payers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "full_name"
    t.string "precision"
    t.string "country_iso_code"
    t.string "currency"
    t.float "minimum_amount"
    t.float "maximum_amount"
    t.string "required_sender_fields"
    t.string "required_beneficiary_fields"
    t.string "destination_info"
    t.integer "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "engine_type"
    t.string "best_partner"
    t.text "partner_codes"
    t.string "alias"
    t.boolean "is_open", default: true
    t.text "available_types"
    t.text "rules"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.decimal "amount", precision: 30
    t.date "date"
    t.string "state"
    t.integer "partner_id"
    t.integer "approved_by_id"
    t.integer "balance_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "trx_type", default: "topup_request"
    t.text "notes"
    t.string "reference_type"
    t.string "reference_id"
    t.integer "unique_code"
    t.boolean "is_robot_payment", default: false
    t.text "bank_code"
    t.decimal "amount_with_code", precision: 30
    t.text "callback_url"
    t.datetime "expires_in"
    t.index ["unique_code"], name: "index_payments_on_unique_code"
  end

  create_table "purpose_of_remittances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "destination_currency"
    t.string "source_currency"
    t.decimal "kurs", precision: 12, scale: 2
    t.decimal "minimum_amount", precision: 12, scale: 2
    t.decimal "maximum_amount", precision: 12, scale: 2
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "minimum_amount_source", precision: 10
    t.decimal "maximum_amount_source", precision: 10
  end

  create_table "recipient_checkers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "account_name"
    t.boolean "is_valid"
    t.string "account_number"
    t.string "bank_name"
    t.datetime "validated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "rollups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "interval"
    t.datetime "time"
    t.float "value"
    t.bigint "partner_id", null: false
    t.string "action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "report_value"
    t.index ["partner_id"], name: "index_rollups_on_partner_id"
  end

  create_table "services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.integer "target_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "single_direct_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "single_reference_id"
    t.float "amount"
    t.integer "batch_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state"
    t.text "quotation_response"
    t.text "confirmation_response"
  end

  create_table "source_of_funds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_faileds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "transaction_id"
    t.string "error_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "reference_id"
    t.string "callback_url"
    t.integer "payer_id"
    t.string "mode"
    t.text "sender"
    t.text "source"
    t.text "destination"
    t.text "beneficiary"
    t.text "compliance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "state"
    t.string "disbursement_reference_id"
    t.string "retry_id"
    t.decimal "amount", precision: 10
    t.datetime "paid_at"
    t.decimal "rate", precision: 19, scale: 6
    t.decimal "fee", precision: 12, scale: 2
    t.integer "partner_id"
    t.datetime "completion_date"
    t.decimal "sent_amount", precision: 14, scale: 4
    t.integer "state_id"
    t.integer "error_code"
    t.text "error_message"
    t.text "partner_error_message"
    t.string "notes"
    t.string "secondary_state", default: "generated"
    t.string "partner_destination", default: "Midtrans"
    t.string "wallet_currency", default: "IDR"
    t.string "transaction_type", default: "C2C"
    t.boolean "is_hidden", default: false
    t.decimal "partner_rate", precision: 28, scale: 18
    t.decimal "partner_fee", precision: 10
    t.string "partner_fee_currency"
    t.integer "balance_id"
    t.string "payment_channel"
    t.boolean "is_regenerated", default: false
    t.string "receipt_url"
    t.index ["disbursement_reference_id"], name: "index_transactions_on_disbursement_reference_id"
    t.index ["reference_id", "user_id"], name: "index_transactions_on_reference_id_and_user_id", unique: true
    t.index ["retry_id"], name: "index_transactions_on_retry_id"
  end

  create_table "transfer_fees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "source_currency"
    t.string "destination_currency"
    t.decimal "fee", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payer_id"
    t.integer "partner_id"
    t.integer "free", default: 0
    t.string "transaction_type"
    t.string "payment_channel"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "partner_id"
    t.boolean "is_api_user", default: false
    t.boolean "is_agreed", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "va_banks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank_code"
    t.string "bank_name"
    t.decimal "min_amount", precision: 10, default: "10000"
    t.decimal "max_amount", precision: 10, default: "50000000"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_direct"
    t.string "prefix_open"
    t.string "prefix_close"
    t.bigint "doorkeeper_id"
    t.index ["doorkeeper_id"], name: "fk_rails_a4b294355a"
  end

  create_table "va_callback_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "va_transaction_id"
    t.text "payload"
    t.string "logging_type"
    t.string "logging_action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "va_numbers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "va_status"
    t.string "va_number"
    t.string "partner_user_id"
    t.string "bank_code"
    t.decimal "amount", precision: 10, default: "0"
    t.boolean "is_open", default: true
    t.boolean "is_single_use", default: false
    t.integer "expiration_time", default: -1
    t.boolean "is_lifetime", default: false
    t.string "username_display"
    t.string "email"
    t.integer "trx_expiration_time", default: -1
    t.string "partner_trx_id"
    t.integer "trx_counter", default: -1
    t.bigint "partner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "counter_incoming_payment", default: 0
    t.string "va_id"
    t.integer "balance_id"
    t.string "callback_url"
    t.bigint "amount_detected", default: 0
    t.boolean "is_direct"
    t.string "phone_number"
    t.index ["partner_id"], name: "index_va_numbers_on_partner_id"
  end

  create_table "va_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "va_number_id"
    t.decimal "amount", precision: 10
    t.boolean "success"
    t.datetime "tx_date"
    t.datetime "trx_expiration_date"
    t.string "trx_id"
    t.datetime "settlement_time"
    t.string "settlement_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fee"
  end

  create_table "va_transfer_fees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank"
    t.string "bank_code"
    t.integer "fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payer_id"
    t.integer "partner_id"
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.datetime "created_at"
    t.text "object_changes", size: :long
    t.string "bank_name"
    t.string "reference_id"
    t.string "partner"
    t.string "whodunnit_name"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "balance_histories", "balances"
  add_foreign_key "balance_ledgers", "balances"
  add_foreign_key "balance_ledgers", "partners"
  add_foreign_key "balances", "users"
  add_foreign_key "idempotent_requests", "partners"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "partner_special_routes", "partners"
  add_foreign_key "partner_special_routes", "payers"
  add_foreign_key "rollups", "partners"
  add_foreign_key "va_banks", "oauth_applications", column: "doorkeeper_id"
  add_foreign_key "va_numbers", "partners"
end
