# WeightConversion (0.1.0)

* [![Code Climate](https://codeclimate.com/github/pzupan/weight_conversion.png)](https://codeclimate.com/github/pzupan/weight_conversion)
* [![Build Status](https://api.travis-ci.org/pzupan/weight_conversion.png)](https://travis-ci.org/shemerey/weight_conversion)
* [![Gem Version](https://badge.fury.io/rb/weight_conversion.png)](http://badge.fury.io/rb/weight_conversion)

Weight object for converting from grams, ounces, pounds and kilograms into a common unit.

Based on Anton Shemerey's Weight gem (https://github.com/shemerey/weight)

## Installation

Add this line to your application's Gemfile:

    $ gem 'weight_conversion'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install weight_conversion

## Usage

### Basic Coversion

```ruby
 Weight.new(1, :lb).to_kgs # => 0.4536
 Weight.new(1, :kg).to_mgs # => 1000.0
 ```

### Basic Math with Weight objects

```ruby
 Weight.new(1, :kg) + Weight.new(1, :kg) == Weight.new(2, :kg)
 Weight.new(1, :kg) - Weight.new(1, :kg) == Weight.new(0, :kg)

 Weight.new(1, :kg) * 2 == Weight.new(2, :kg)
 Weight.new(2, :kg) / 2 == Weight.new(1, :kg)
```

#### Convert result to the first object unit system

```ruby
 Weight.new(1, :kg) + Weight.new(1, :lb) # =>   #<Weight: @input_value=1.4536, @input_unit=:kg>
 Weight.new(1, :lb) + Weight.new(1, :kg) # =>   #<Weight: @input_value=3.2046, @input_unit=:lb>
```

### Basic comparison with Weight objects

```ruby
 Weight.new(3, :lb).between?(Weight.new(1, :kg), Weight.new(2, :kg))
 Weight.new(1, :kg) > Weight.new(2, :lb)
 Weight.new(1, :lb) <= Weight.new(0.5, :kg)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/weight_conversion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
