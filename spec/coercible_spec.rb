require 'spec_helper'
require 'date'

describe StronglyTyped::Coercible, '#coerce' do

  it 'converts some Fixnum to anything' do
    coerce(100, to: Float).should eql(100.0)
    coerce(100, to: String).should eql("100")
    coerce(100, to: Boolean).should be(true)
    coerce(100, to: Rational).should eql(Rational(100/1))
    coerce(100, to: Complex).should eql(Complex(100, 0))
    coerce(100, to: Time).should be_kind_of(Time)
    coerce(100, to: Date).should be_kind_of(Date)
  end

  it 'raises exception when trying to convert some Numeric to Symbol' do
    expect { coerce(100, to: Symbol) }.to raise_error(TypeError)
    expect { coerce(100.0, to: Symbol) }.to raise_error(TypeError)
    expect { coerce(9**20, to: Symbol) }.to raise_error(TypeError)
    expect { coerce(Rational(100/1), to: Symbol) }.to raise_error(TypeError)
    expect { coerce(Complex(100, 0), to: Symbol) }.to raise_error(TypeError)
  end

  it 'converts some Float to anything' do
    coerce(100.0, to: Integer).should eql(100)
    coerce(100.0, to: String).should eql("100.0")
    coerce(100.0, to: Boolean).should be(true)
    coerce(100.5, to: Rational).should eql(Rational(201.0/2))
    coerce(100.5, to: Complex).should eql(Complex(100.5, 0))
    coerce(100.0, to: Time).should be_kind_of(Time)
  end

  it 'raises exception when trying to convert some Numeric to Date' do
    expect { coerce(1, to: Date) }.to raise_error(ArgumentError)
    expect { coerce(1.0, to: Date) }.to raise_error(TypeError)
    expect { coerce(9**20, to: Date) }.to raise_error(ArgumentError)
    expect { coerce(Rational(100/1), to: Date) }.to raise_error(TypeError)
    expect { coerce(Complex(100, 0), to: Date) }.to raise_error(TypeError)
  end

  it 'converts dates' do
    coerce(Date.new(2013, 02, 21), to: DateTime).should == DateTime.new(2013, 02, 21)
    coerce(Time.new(2013,02,20,10,20,30,0), to: DateTime).should == DateTime.new(2013,02,20,10,20,30,0)
    coerce(20130221, to: DateTime).should == DateTime.new(2013, 02, 21)
  end

  it 'raises exception when trying to convert some Numeric to DateTime' do
    expect { coerce(1, to: DateTime) }.to raise_error(ArgumentError)
    expect { coerce(1.0, to: DateTime) }.to raise_error(TypeError)
    expect { coerce(9**20, to: DateTime) }.to raise_error(ArgumentError)
    expect { coerce(Rational(100/1), to: DateTime) }.to raise_error(TypeError)
    expect { coerce(Complex(100, 0), to: DateTime) }.to raise_error(TypeError)
  end

  it 'raises exception when trying to convert to non primitive types' do
    expect { coerce(1, to: Object) }.to raise_error(TypeError)
    expect { coerce(1.0, to: Module) }.to raise_error(TypeError)
    expect { coerce("str", to: Class) }.to raise_error(TypeError)
  end

  it 'raises exception when trying to convert to Bignum' do
    expect { coerce(100, to: Bignum) }.to raise_error(TypeError)
  end

end
