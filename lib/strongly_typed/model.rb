require "strongly_typed/attributes"

module StronglyTyped
  module Model
    # @private
    def self.included(klass)
      klass.class_eval do
        extend StronglyTyped::Attributes
        include StronglyTyped::Coercible
      end
    end

    # Entity constructor delegator
    #
    # @overload initialize(hsh)
    #   Accepts key values from a hash
    #   @param (see #initialize_from_hash)
    # @overload initialize(values)
    #   Accepts values from ordered arguments
    #   @param (see #initialize_from_ordered_args)
    #
    # @example (see #initialize_from_hash)
    # @example (see #initialize_from_ordered_args)
    #
    # @raise (see #initialize_from_hash)
    # @raise (see #initialize_from_ordered_args)
    def initialize(*args)
      raise ArgumentError, "Need arguments to build your tiny model" if args.empty?

      if args.size == 1 && args.first.kind_of?(Hash)
        initialize_from_hash(args)
      else
        initialize_from_ordered_args(args)
      end
    end

    private

    # Entity constructor from a Hash
    #
    # @param [Hash] hsh hash of values
    #
    # @example
    #   class Person
    #     include StronglyTyped::Model
    #
    #     attribute :id, Integer
    #     attribute :slug, String
    #   end
    #
    #   Person.new(id: 1, slug: 'elgalu')
    #   #=> #<Person:0x00c98 @id=1, @slug="elgalu">
    #   leo.id   #=> 1
    #   leo.slug #=> "elgalu"
    #
    # @raise [NameError] if tries to assign a non-existing member
    #
    # @private
    def initialize_from_hash(hsh)
      hsh.first.each_pair do |k, v|
        if self.class.members.include?(k.to_sym)
          self.public_send("#{k}=", v)
        else
          raise NameError, "Trying to assign non-existing member #{k}=#{v}"
        end
      end
    end

    # Entity constructor from ordered params
    #
    # @param [Array] values ordered values
    #
    # @example
    #   class Person
    #     include StronglyTyped::Model
    #
    #     attribute :id, Integer
    #     attribute :slug, String
    #   end
    #
    #   Person.new(1, 'elgalu')
    #   #=> #<Person:0x00c99 @id=1, @slug="elgalu">
    #   leo.id   #=> 1
    #   leo.slug #=> "elgalu"
    #
    # @raise [ArgumentError] if the arity doesn't match
    #
    # @private
    def initialize_from_ordered_args(values)
      raise ArgumentError, "wrong number of arguments(#{values.size} for #{self.class.members.size})" if values.size > self.class.members.size

      values.each_with_index do |v, i|
        # instance_variable_set("@#{self.class.members[i]}", v)
        self.public_send("#{self.class.members[i]}=", v)
      end
    end

  end
end
