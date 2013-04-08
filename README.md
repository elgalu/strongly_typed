# StronglyTyped

[![Gem Version][GV img]][Gem Version]
[![Build Status][BS img]][Build Status]
[![Dependency Status][DS img]][Dependency Status]
[![Code Climate][CC img]][Code Climate]
[![Coverage Status][CS img]][Coverage Status]

## Description

This gem provides similar functionality as ruby core [Struct][] but instead of [inheritance][] i used [mixins][] and even wrote [something][blog on mixins] about my reasons to do so.

Same as [Struct][], it is a convenient way to bundle a number of attributes together using accessor methods with added features like basic type validation and type conversions when [possible][specs on conversions].

## Similar Tools

From ruby core you have [Struct][] and from stdlib [OpenStruct][].

Check [virtus][] if you are looking for a full featured attributes settings for your Ruby Objects that requires complex automatic coercions among other things.

If you are looking for a nestable, coercible, Hash-like data structure take a look at [structure][] gem.

## Reasons

I took some ideas from others gems like [virtus][] and [structure][] but since none of them provided exactly what i needed then decided to create this gem for [twitter_anonymous_client][] gem and the blog [post][blog on create gem] i wrote about it.

## Installation

Add `gem 'strongly_typed'` to your [Gemfile][] then run [bundle install][] or simply `$ gem install strongly_typed`

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

1. Fork it.
2. Make your feature addition or bug fix and create your feature branch.
3. Update the [Change Log][].
3. Add specs/tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, create a new Pull Request.
5. Check that your pull request passes the [build][travis pull requests].

### TODO for StronglyTyped::Model
+ Add :default => 'value' to attribute() to support defaults
+ Add :required => true/false to attribute() so an ArgumentError is raised when not provided

### TODO for StronglyTyped::Coercible
+ Extract coercer to another gem or use already existing coercion gem
+ Improve generic TypeError to also show attribute name, expected type and value received instead
+ On coercible.rb require gem 'double' to avoid requiring 'date' when user doesn't need that
+ Add support for BigDecimal

## License

Released under the MIT License. See the [LICENSE][] file for further details.

## Links

[RubyGems][] | [Documentation][] | [Source][] | [Bugtracker][] | [Build Status][] | [Dependency Status][] | [Code Climate][]

[bundle install]: http://gembundler.com/v1.3/man/bundle-install.1.html
[Gemfile]: http://gembundler.com/v1.3/gemfile.html
[LICENSE]: LICENSE.md
[Change Log]: CHANGELOG.md

[RubyGems]: https://rubygems.org/gems/strongly_typed
[Documentation]: http://rubydoc.info/gems/strongly_typed
[Source]: https://github.com/elgalu/strongly_typed
[Bugtracker]: https://github.com/elgalu/strongly_typed/issues
[travis pull requests]: https://travis-ci.org/elgalu/strongly_typed/pull_requests

[Gem Version]: https://rubygems.org/gems/strongly_typed
[Build Status]: https://travis-ci.org/elgalu/strongly_typed
[Dependency Status]: https://gemnasium.com/elgalu/strongly_typed
[Code Climate]: https://codeclimate.com/github/elgalu/strongly_typed
[Coverage Status]: https://coveralls.io/r/elgalu/strongly_typed

[GV img]: https://badge.fury.io/rb/strongly_typed.png
[BS img]: https://travis-ci.org/elgalu/strongly_typed.png
[DS img]: https://gemnasium.com/elgalu/strongly_typed.png
[CC img]: https://codeclimate.com/github/elgalu/strongly_typed.png
[CS img]: https://coveralls.io/repos/elgalu/strongly_typed/badge.png?branch=master

[strongly_typed]: https://github.com/elgalu/strongly_typed
[full API here]: http://rubydoc.info/gems/strongly_typed/frames/file/README.md
[specs on conversions]: https://github.com/elgalu/strongly_typed/blob/master/spec/coercible_spec.rb
[blog on create gem]: http://elgalu.github.com/2013/tools-for-creating-your-first-ruby-gem/
[blog on mixins]: http://elgalu.github.com/2013/when-to-use-ruby-inheritance-versus-mixins/
[twitter_anonymous_client]: https://github.com/elgalu/twitter_anonymous_client
[named parameters]: http://en.wikipedia.org/wiki/Named_parameter
[Struct]: http://www.ruby-doc.org/core-1.9.3/Struct.html
[OpenStruct]: http://ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html
[structure]: https://github.com/hakanensari/structure
[virtus]: https://github.com/solnic/virtus
[inheritance]: http://en.wikipedia.org/wiki/Inheritance_(computer_science)
[mixins]: http://en.wikipedia.org/wiki/Mixin
