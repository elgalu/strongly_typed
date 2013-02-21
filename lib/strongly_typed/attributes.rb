module StronglyTyped
  module Attributes

    # Create attribute accesors for the included class
    #   Also validations and coercions for the type specified
    #
    # @param [Symbol] name the accessor name
    # @param [Class] type the class type to use for validations and coercions
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
    def attribute(name, type=Object)
      name = name.to_sym #normalize

      raise NameError, "attribute `#{name}` already created" if members.include?(name)
      raise TypeError, "second argument, type, must be a Class but got `#{type.inspect}` insted" unless type.is_a?(Class)
      raise TypeError, "directly converting to Bignum is not supported, use Integer instead" if type == Bignum

      new_attribute(name, type)
    end

    # Memoized hash storing keys for names & values for types pairs
    #
    # @return [Hash] attributes
    def attributes
      @attributes ||= {}
    end

    # Returns the attribute names created with attribute()
    #
    # @return [Array<Symbol>] all the attribute names
    def members
      attributes.keys
    end

    private

    # Add new attribute for the tiny object modeled
    #
    # @param [Symbol] name the attribute name
    # @param [Class] type the class type
    #
    # @private
    def new_attribute(name, type)
      attributes[name] = type
      define_attr_reader(name)
      define_attr_writer(name, type)
      name
    end

    # Define attr_reader method for the new attribute
    #
    # @param [Symbol] name the attribute name
    #
    # @private
    def define_attr_reader(name)
      define_method(name) do
        instance_variable_get("@#{name}")
      end
    end

    # Define attr_writer method for the new attribute
    #   with the added feature of validations and coercions.
    #
    # @param [Symbol] name the attribute name
    # @param [Class] type the class type
    #
    # @raise [TypeError] if unable to coerce the value
    #
    # @private
    def define_attr_writer(name, type)
      define_method("#{name}=") do |value|
        unless value.kind_of?(type)
          value = coerce(value, to: type)
          unless value.kind_of?(type)
            raise TypeError, "Attribute `#{name}` only accepts `#{type}` but got `#{value}`:`#{value.class}` instead"
          end
        end
        instance_variable_set("@#{name}", value)
      end
    end

  end
end
