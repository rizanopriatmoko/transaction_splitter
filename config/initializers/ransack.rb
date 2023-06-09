Ransack.configure do |config|
  config.add_predicate 'hash_cont',
    arel_predicate: 'matches',
    formatter: proc { |v| v.chomp },
    validator: proc { |v| v.present? },
    type: :string
end