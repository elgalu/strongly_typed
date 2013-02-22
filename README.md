# StronglyTyped

[![Build Status](https://travis-ci.org/elgalu/strongly_typed.png)](https://travis-ci.org/elgalu/strongly_typed)
[![Dependency Status](https://gemnasium.com/elgalu/strongly_typed.png)](https://gemnasium.com/elgalu/strongly_typed)
[![Code Climate](https://codeclimate.com/github/elgalu/strongly_typed.png)](https://codeclimate.com/github/elgalu/strongly_typed)

This gem provides similar functionality as ruby core [Struct][] but instead of [inheritance][] i used [mixins][] and even wrote [something][blog on mixins] about my reasons to do so.

Same as [Struct][], it is a convenient way to bundle a number of attributes together using accessor methods with added features like basic type validation and type conversions when [possible][specs on conversions].

## Similar Tools

From ruby core you have [Struct][] and from stdlib [OpenStruct][].

Check [virtus][] if you are looking for a full featured attributes settings for your Ruby Objects that requires complex automatic coercions among other things.

If you are looking for a nestable, coercible, Hash-like data structure take a look at [structure][] gem.

## Reasons

I took some ideas from others gems like [virtus][] and [structure][] but since none of them provided exactly what i needed then decided to create this gem for my sample gem project [dolarblue][] and the blog [post][blog on dolarblue] i wrote about it.

## Installation

Add this line to your application's Gemfile:

    gem 'strongly_typed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strongly_typed

## Usage

Include `StronglyTyped::Model` on you ruby objects then call `attribute()` to define them.

```ruby
require 'strongly_typed'

class Person
  include StronglyTyped::Model

  attribute :id, Integer
  attribute :slug, String
end
```

Instance initialization with a hash, a.k.a [named parameters][]

```ruby
leo = Person.new(id: 1, slug: 'elgalu')
#=> #<Person:0x00c98 @id=1, @slug="elgalu">
leo.id   #=> 1
leo.slug #=> "elgalu"
```

Can also trust in the parameters order

```ruby
leo = Person.new(1, 'elgalu')
#=> #<Person:0x00c99 @id=1, @slug="elgalu">
leo.id   #=> 1
leo.slug #=> "elgalu"
```

Hash Order doesn't matter

```ruby
ana = Person.new(slug: 'anapau', id: 2)
#=> #<Person:0x00d33 @id=2, @slug="anapau">
ana.id   #=> 2
ana.slug #=> "anapau"
```

TypeError is raised when improper type

```ruby
ted = Person.new(id: nil, slug: 'teddy')
#=> TypeError: can't convert nil into Integer
```

Check the [full API here][]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### TODO for StronglyTyped::Model
+ Add :default => 'value' to attribute() to support defaults
+ Add :required => true/false to attribute() so an ArgumentError is raised when not provided

### TODO for StronglyTyped::Coercible
+ Extract coercer to another gem or use already existing coercion gem
+ Improve generic TypeError to also show attribute name, expected type and value received instead
+ On coercible.rb require gem 'double' to avoid requiring 'date' when user doesn't need that
+ Add support for BigDecimal


[strongly_typed]: https://github.com/elgalu/strongly_typed
[full API here]: http://rubydoc.info/gems/strongly_typed/frames/file/README.md
[specs on conversions]: https://github.com/elgalu/strongly_typed/blob/master/spec/coercible_spec.rb
[blog on dolarblue]: http://elgalu.github.com/2013/tools-for-creating-your-first-ruby-gem-dolarblue/
[blog on mixins]: http://elgalu.github.com/2013/when-to-use-ruby-inheritance-versus-mixins/
[named parameters]: http://en.wikipedia.org/wiki/Named_parameter
[Struct]: http://www.ruby-doc.org/core-1.9.3/Struct.html
[OpenStruct]: http://ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html
[structure]: https://github.com/hakanensari/structure
[virtus]: https://github.com/solnic/virtus
[inheritance]: http://en.wikipedia.org/wiki/Inheritance_(computer_science)
[mixins]: http://en.wikipedia.org/wiki/Mixin
