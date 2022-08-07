puts 'Begin database seeding'

security_ids = []
while true do
  begin
    security_ids << Security.create(
      symbol: Faker::Finance.unique.ticker,
      buy_cost: rand(100) + 1,
      sell_cost: rand(100) + 1,
      value: rand(100) + 1
    ).id
  rescue Faker::UniqueGenerator::RetryLimitExceeded
    break
  end
end

asset_class_ids = []

%i[industry super_sector sector sub_sector].each do |factory|
  while true do
    begin
      asset_class_ids << AssetClass.create(
        name: Faker::IndustrySegments.unique.send(factory)
      ).id
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      break
    end
  end
end

asset_class_ids.each do |asset_class_id|
  [5, 5, 4, 4, 3, 3, 2, 1].sample.times do
    AssetClassSecurity.create(
      asset_class_id: asset_class_id,
      security_id: security_ids.sample
    )
  end
end

portfolio_ids = 100.times.map do
  Portfolio.create(
    name: Faker::Barcode.unique.upc_a_with_composite_symbology
  ).id
end

portfolio_ids.each do |portfolio_id|
  counter = 0
  numbers = []
  while(counter < 100)
    num = rand(5) + 1
    counter += num
    numbers << num
  end
  sampled_asset_class_ids = asset_class_ids.sample(rand(5) + 2)
  allocations = numbers.reject(&:zero?).shuffle.in_groups(sampled_asset_class_ids.count, false).map(&:sum)
  sampled_asset_class_ids.zip(allocations).each do |asset_class_id, amount|
    Allocation.create(
      portfolio_id: portfolio_id,
      asset_class_id: asset_class_id,
      amount: amount,
    )
  end
end

client_ids = 1000.times.map do
  Client.create(
    name: Faker::Name.name,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    postal: Faker::Address.postcode,
    province: Faker::Address.state,
    country: Faker::Address.country,
    phone: Faker::PhoneNumber.phone_number
  ).id
end

account_ids = []
client_ids.flat_map do |client_id|
  portfolio_ids.shuffle.take([2, 2, 2, 3, 3, 1].sample).each.map do |portfolio_id|
    account = Account.create(
      client_id: client_id,
      canonical_id: Faker::Bank.unique.iban,
      portfolio_id: portfolio_id,
      name: %w(RRSP TFSA Savings Cash RESP).sample
    )
    account.portfolio.allocations.each do |allocation|
      sample_security_ids = allocation.asset_class.securities.map(&:id)
      sample_security_ids = sample_security_ids.shuffle.take(rand(sample_security_ids.count) + 1)
      sample_security_ids.each do |security_id|
        account.positions.create(
          security_id: security_id,
          quantity: rand(1000) + 10
        )
      end
    end
    account_ids << account.id
  end
end

1000.times do
  Order.create(
    account_id: account_ids.sample,
    security_id: security_ids.sample,
    order_type: %w[BUY_VALUE SELL_VALUE BUY_QUANTITY SELL_QUANTITY].sample,
    amount: rand(5000) + 100,
    posted_at: Time.now - rand(60).days
  )
end

1000.times do
  posted_at = Time.now - rand(60).days
  Activity.create(
    account_id: account_ids.sample,
    security_id: security_ids.sample,
    activity_type: %w[BUY_VALUE SELL_VALUE BUY_QUANTITY SELL_QUANTITY DEPOSIT].sample,
    amount: rand(5000) + 100,
    posted_at: posted_at,
    effective_on: posted_at + rand(2).days
  )
end

puts 'Finished database seeding'
