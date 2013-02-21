require 'boolean_class'
require 'date'

module StronglyTyped
  module Coercible
    LOCAL_OFFSET = Float(Time.now.gmt_offset) / Float(3600)

    # Coerce (convert) a value to some specified type
    #
    # @param [Object] value the value to coerce
    # @param [Hash] opts the conversion options
    # @option opts [Class, Module] :to the type to convert to
    #
    # @return [Object] the converted value into the specified type
    #
    # @example
    #   include StronglyTyped::Coercible
    #
    #   coerce 100, to: Float   #=> 100.0
    #   coerce 100              #=> ArgumentError: Needs option :to => Class/Module
    #   coerce 100, to: String  #=> "100"
    #   coerce 100, to: Boolean #=> true
    #   coerce 100, to: Symbol  #=> TypeError: can't convert `100:Fixnum` to `Symbol`
    #
    # @raise [ArgumentError] if :to => Class option was not provided correctly
    # @raise [TypeError] if unable to perform the coersion
    def coerce(value, opts={})
      raise ArgumentError, "Needs option :to => Class/Module" unless opts.has_key?(:to) && ( opts[:to].is_a?(Class) || opts[:to].is_a?(Module) )
      type = opts[:to]

      case
      # Direct conversions
      when type <= String   then String(value)
      when type <= Boolean  then Boolean(value)
      when type == Bignum   then raise TypeError, "directly converting to Bignum is not supported, use Integer instead"
      when type <= Integer  then Integer(value)
      when type <= Float    then Float(value)
      when type <= Rational then Rational(value)
      when type <= Complex  then Complex(value)
      # Symbol
      when type <= Symbol && value.respond_to?(:to_sym)
        value.to_sym
      # Dates and Times
      when type <= Time && value.is_a?(Numeric)
        Time.at(value)
      when type <= Time && value.is_a?(String)
        DateTime.parse(value).new_offset(LOCAL_OFFSET/24).to_time
      when type <= DateTime && value.respond_to?(:to_datetime)
        value.to_datetime.new_offset(LOCAL_OFFSET/24)
      when type <= DateTime && value.is_a?(String)
        DateTime.parse(value).new_offset(LOCAL_OFFSET/24)
      when type <= DateTime && value.is_a?(Integer)
        DateTime.parse(value.to_s).new_offset(LOCAL_OFFSET/24)
      # Important: DateTime < Date so the order in this case statement matters
      when type <= Date && value.is_a?(String)
        Date.parse(value)
      when type <= Date && value.is_a?(Integer)
        Date.parse(value.to_s)
      else
        raise TypeError, "can't convert `#{value}:#{value.class}` to `#{type}`"
      end
    end
  end
end
