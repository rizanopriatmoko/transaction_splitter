# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "partner_china@mail.com", password: "password", password_confirmation: "password")
Balance.create(currency: "IDR", balance: "80000000", is_active: true, user_id: User.last.id)

bene_relationships = [{"code":"AUNT","name":"Aunt"},
    {"code":"BROTHER","name":"Brother"},
    {"code":"BROTHER_IN_LAW","name":"Brother-in-law"},
    {"code":"COUSIN","name":"Cousin"},
    {"code":"DAUGHTER","name":"Daughter"},
    {"code":"FATHER","name":"Father"},
    {"code":"FATHER_IN_LAW","name":"Father-in-law"},
    {"code":"FRIEND","name":"Friend"},
    {"code":"GRAND_FATHER","name":"Grandfather"},
    {"code":"GRAND_MOTHER","name":"Grandmother"},
    {"code":"HUSBAND","name":"Husband"},
    {"code":"MOTHER","name":"Mother"},
    {"code":"MOTHER_IN_LAW","name":"Mother-in-law"},
    {"code":"NEPHEW","name":"Nephew"},
    {"code":"NIECE","name":"Niece"},
    {"code":"SELF","name":"Self (i.e. the sender, himself)"},
    {"code":"SISTER","name":"Sister"},
    {"code":"SISTER_IN_LAW","name":"Sister-in-law"},
    {"code":"SON","name":"Son"},
    {"code":"UNCLE","name":"Uncle"},
    {"code":"WIFE","name":"Wife"},
    {"code":"OTHER","name":"Others not listed"}]

bene_relationships.map{|x| BeneficiaryRelationship.create(name: x[:name], code: x[:code])}

source_of_funds = [{"code":"CASH","name":"Cash"},
    {"code":"BUSINESS","name":"Business"},
    {"code":"GIFT","name":"Gift"},
    {"code":"SALARY","name":"Salary"},
    {"code":"LOTTERY","name":"Lottery"},
    {"code":"SAVINGS","name":"Savings"},
    {"code":"OTHER","name":"Others not listed"}]

source_of_funds.map{|x| SourceOfFund.create(name: x[:name], code: x[:code])}

purposes = [{"code":"FAMILY_SUPPORT","name":"Family support"},{"code":"EDUCATION","name":"Education"},{"code":"GIFT_AND_DONATION","name":"Gift and other donations"},{"code":"MEDICAL_TREATMENT","name":"Medical treatment"},{"code":"MAINTENANCE_EXPENSES","name":"Maintenance or other expenses"},{"code":"TRAVEL","name":"Travel"},{"code":"SMALL_VALUE_REMITTANCE","name":"Small value remittance"},{"code":"LIBERALIZED_REMITTANCE","name":"Liberalized remittance"},{"code":"CONSTRUCTION_EXPENSES","name":"Construction expenses"},{"code":"HOTEL_ACCOMMODATION","name":"Hotel accommodation"},{"code":"ADVERTISING_EXPENSES","name":"Advertising and/or public relations related expenses"},{"code":"ADVISORY_FEES","name":"Fees for advisory or consulting service"},{"code":"BUSINESS_INSURANCE","name":"Business related insurance payment"},{"code":"INSURANCE_CLAIMS","name":"Insurance claims payment"},{"code":"DELIVERY_FEES","name":"Delivery fees"},{"code":"EXPORTED_GOODS","name":"Payments for exported goods"},{"code":"SERVICE_CHARGES","name":"Payment for services"},{"code":"LOAN_PAYMENT","name":"Payment of loans"},{"code":"OFFICE_EXPENSES","name":"Office expenses"},{"code":"PROPERTY_PURCHASE","name":"Residential property purchase"},{"code":"PROPERTY_RENTAL","name":"Property rental payment"},{"code":"ROYALTY_FEES","name":"Royalty, trademark, patent and copyright fees"},{"code":"SHARES_INVESTMENT","name":"Investment in shares"},{"code":"FUND_INVESTMENT","name":"Fund investment"},{"code":"TAX_PAYMENT","name":"Tax payment"},{"code":"TRANSPORTATION_FEES","name":"Transportation fees"},{"code":"UTILITY_BILLS","name":"Utility bills"},{"code":"PERSONAL_TRANSFER","name":"Personal transfer"},{"code":"SALARY_PAYMENT","name":"Payment of salary"},{"code":"OTHER_FEES","name":"Broker, commitment, guarantee and other fees"},{"code":"OTHER","name":"Other purposes"}]

purposes.map{|x| PurposeOfRemittance.create(name: x[:name], code: x[:code])}

Service.create(name: "Bank Account", is_active: true)

sender_required_fields = [:firstname, :last_name, :nationality, :date_of_birth, :country_of_birth, :gender, :address, :zip_code, :city, :country_iso_code, :country_iso, :email, :id_type, :id_country_iso_code, :id_number]
beneficiary_required_fields = [:firstname, :lastname, :nationality, :date_of_birth, :country_of_birth, :gender, :address, :zip_code, :city, :country_iso_code, :country_iso, :email, :id_type, :id_country_iso_code, :id_number, :bank, :account]

banks = ["bni", "mandiri", "bri", "bci", "cimb"]

banks.map{|x| Payer.create(name: x, precision: 2, country_iso_code: "IDN", currency: "IDR", minimum_amount: 100000, maximum_amount: 2000000000, required_sender_fields: sender_required_fields, required_beneficiary_fields: beneficiary_required_fields, service_id: Service.last.id)}

va_banks = [
  {bank_code: '002', bank_name: 'Bank BRI'},
  {bank_code: '013', bank_name: 'Bank Permata'},
  {bank_code: '022', bank_name: 'Bank CIMB Niaga'},
  {bank_code: '008', bank_name: 'Bank Mandiri'},
  {bank_code: '009', bank_name: 'Bank BNI'},
  {bank_code: '014', bank_name: 'Bank BCA'},
  {bank_code: '213', bank_name: 'Bank BTPN'}
]

va_banks.map{|x| VaBank.create(bank_name: x[:bank_name], bank_code: x[:bank_code])}
