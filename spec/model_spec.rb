require 'spec_helper'
require 'date'

describe StronglyTyped::Model do

  before(:all) do
    class Person
      include StronglyTyped::Model

      attribute :id, Integer
      attribute :name, String
      attribute :slug, Symbol
      attribute :dob, Date
      attribute :last_seen, DateTime
    end
  end

  context 'when a Person is correctly created on initialize' do
    let(:leo) { Person.new id: 1122,
                           name: 'Leo Gallucci',
                           slug: :elgalu,
                           dob: '1981-05-28',
                           last_seen: Time.new(2013,02,21,06,37,40,0)
              }

    it 'should have the correct attribute accessors, values and types' do
      leo.id.should == Integer(1122)
      leo.name.should == "Leo Gallucci"
      leo.slug.should == :elgalu
      leo.dob.should == Date.new(1981, 05, 28)
      leo.last_seen.should == DateTime.new(2013,02,21,06,37,40,0)
    end
  end

  context 'when a Person is initially created with no initial values' do
    subject { Person.new }

    it 'should raise ArgumentError' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  context 'when a Person is initially created with almost no values' do
    let(:leo) { Person.new(id: 1) }

    context 'and their members are initialized later on' do
      it 'is possible to initialize it with correct types' do
        leo.id = 1122
        leo.name = 'Leo Gallucci'
        leo.slug = :elgalu
        leo.dob = Date.new(1981, 05, 28)
        leo.last_seen = DateTime.new(2013,02,21,06,37,40,0)
        # assert:
        leo.id.should == Integer(1122)
        leo.name.should == "Leo Gallucci"
        leo.slug.should == :elgalu
        leo.dob.should == Date.new(1981, 05, 28)
        leo.last_seen.should == DateTime.new(2013,02,21,06,37,40,0)
      end

      it 'is possible to intialize it with similar types that will be automatically converted' do
        leo.id = "1122"
        leo.name = 'Leo Gallucci'
        leo.slug = "elgalu"
        leo.dob = 19810528
        leo.last_seen = Time.new(2013,02,21,06,37,40,0)
        # assert:
        leo.id.should == 1122
        leo.name.should == "Leo Gallucci"
        leo.slug.should == :elgalu
        leo.dob.should == Date.new(1981, 05, 28)
        leo.last_seen.should == DateTime.new(2013,02,21,06,37,40,0)
      end
    end
  end

  context 'when a Person is tried to initialized with invalid types' do
    it 'raise TypeError when try to coerce nil to Integer' do
      expect { Person.new id: nil }.to raise_error(TypeError)
    end

    it 'raise TypeError when try to coerce 100 to Symbol' do
      expect { Person.new slug: 100 }.to raise_error(TypeError)
    end

    it 'raise TypeError when try to coerce nil to Date' do
      expect { Person.new dob: nil }.to raise_error(TypeError)
    end

    it 'raise TypeError when try to coerce nil to DateTime' do
      expect { Person.new id: nil }.to raise_error(TypeError)
    end
  end

end
