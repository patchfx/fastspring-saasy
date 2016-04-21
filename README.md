# fastspring-saasy

Ruby library to access the FastSpring Saasy API.

## Installation

```ruby
gem install fastspring-saasy
```

## Usage

### Setup account credentials
```ruby
FastSpring::Account.setup do |config|
	config[:username] = 'user'
    config[:password] = 'password'
   	config[:company] = 'company'
end
```

## Get subscription
```ruby
sub = FastSpring::Subscription.find('reference')
```

### Renew subscription
```ruby
sub.renew
```

### Update subscription
```ruby
attributes = {
	first_name: 'John',
    last_name: 'Doe',
    company: 'Doe Inc.',
    email: 'john.doe@example.com',
    phone_number: '+1 123 456 789',
    product_path: '/product',
    quantity: 1,
    tags: 'tag1, tag2, tag3',
    coupon: 'code',
    proration: true
}
sub.update!(attributes)
```

### Cancel subscription
```ruby
sub.cancel!
```

### Create subscriptions url
```ruby
FastSpring::Subscription.create_subscription_url('test_product', 'new_co')
=> http://sites.fastspring.com/acme/product/test_product?referrer=new_co
```

### Search Orders
```ruby
orders = FastSpring::Order.search('search-string')
orders.each do |order|
  puts order.inspect
end
```

### Find Order
```ruby
order = FastSpring::Order.find('reference')
order.items.each do |item|
  puts item.inspect
end

order.payments.each do |payment|
  puts payment.inspect
end

#customer details
order.purchaser.inspect
```

### Localized Store Pricing
```ruby
store_pricing = FastSpring::LocalizedStorePricing.find(['/standard'], http_request)

puts store_pricing.inspect
```

## Copyright

Copyright (c) 2016 Richard Patching. See LICENSE.txt for further details.