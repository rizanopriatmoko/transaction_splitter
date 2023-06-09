json.extract! batch_trx, :id, :name, :address, :phone, :email_pic, :api_user_id, :created_at, :updated_at
json.url admin_partner_url(batch_trx, format: :json)
