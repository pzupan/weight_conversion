require 'spec_helper'

I18n.enforce_available_locales = false
#I18n.locale = :en

#I18n.load_path = (
#puts  Pathname.new(__dir__).to_s.split(/\//)[0...-1] + ['config', 'locales', '**/*.yml']).join('/')


describe Weight do

  let(:one_kg) { Weight.new(1, :kg) }
  let(:one_lb) { Weight.new(1, :lb) }
  let(:one_oz) { Weight.new(1, :oz) }
  let(:one_gm) { Weight.new(1, :gm) }

  it 'should take two options value and unit type' do
    expect(Weight.new(1, :lb)).to be_instance_of(Weight)
  end

  it 'should translate' do
    skip
    expect(one_kg.translated).to eq('Kilogram')
  end

  describe 'math operators' do
    it 'for minus operator result unit should be equal to first object unit' do
      expect((one_kg - one_lb).unit).to eq(:kg)
    end

    it 'for plus operator result unit should be equal to first object unit' do
      expect((one_kg + one_lb).unit).to eq(:kg)
    end

    it 'minus operator should compute weight objects with different units properly' do
      expect(one_kg - one_lb).to be > one_lb
      expect(one_lb - one_oz).to be < one_lb
    end

    it 'plua operator should compute weight objects with different units properly' do
      expect(one_gm + one_oz).to be < one_lb
      expect(one_oz + one_lb).to be > one_lb
    end

    it 'plus operator should have proper result' do
      expect(one_lb + one_lb).to eq(Weight.new(2, :lb))
    end

    it 'two objects with the same weight and type should be equal' do
      expect(one_kg).to eq(Weight.new(1, :kg))
    end

    it 'operation resulting in zero is okay' do
      expect(one_lb - one_lb).to eq(Weight.new(0, :lb))
    end

    it 'times operator should have proper result' do
      expect(one_lb * 2).to eq(Weight.new(2, :lb))
    end

    it 'operation on something that is not a Weight should raise an error' do
      expect do 
        (one_lb + 1)
      end.to raise_error(TypeError)
    end

    it 'attempting to multiply a weight by another weight should raise an error' do
      expect do 
        (one_lb * one_lb)
      end.to raise_error(TypeError)
    end

    it 'multiplication should have proper result' do
      expect(one_kg * 2).to eq(Weight.new(2, :kg))
    end

    it 'division should have proper result' do
      expect(Weight.new(2, :kg) / 2).to eq(one_kg)
    end

    it 'attempting to divide a weight by another weight should raise an error' do
      expect do 
        (one_lb / one_lb)
      end.to raise_error(TypeError)
    end
  end

  describe 'calculation between different units' do
    it 'should convert 1 kg to 2.2046 lbs' do
      expect(Weight.new(1, :kg).to_lbs).to eq(2.2046)
    end

    it 'should convert 1 lbs to 0.45359 kg' do
      expect(Weight.new(1, :lb).to_kgs).to eq(0.4536)
    end

    it 'should convert 1 kg to 35.2740 ounces' do
      expect(Weight.new(1, :kg).to_ozs).to eq(35.2740)
    end

    it 'should convert 1 kg to 1000 grams' do
      expect(Weight.new(1, :kg).to_gms).to eq(1000)
    end

    it 'should convert 1000 gms to 1 kg' do
      expect(Weight.new(1000, :gm).to_kgs).to eq(1)
    end

    it 'should convert 28.3495 gms to 1 oz' do
      expect(Weight.new(28.3495, :gm).to_ozs).to eq(1)
    end

    it 'should convert 453.5923 gms to 1 lb' do
      expect(Weight.new(453.5923, :gm).to_lbs).to eq(1)
    end

    it 'should convert 0 kgs to 0 lb' do
      expect(Weight.new(0, 'kg').to_lbs).to eq(0.0)
    end

    it 'should raise an error when the weight is negative' do
      expect do
        Weight.new(-1, 'kg')
      end.to raise_error(TypeError)
    end

    it 'should return the weight in pounds when converted to_f' do
      expect(Weight.new(0.6, 'lb').to_f).to eq(0.6)
    end

    it 'should round 0.6 lbs to 1 lb when converted to_i' do
      expect(Weight.new(0.6, 'lb').to_i).to eq(1)
    end

    it 'should round 0.5 lbs to 1 lb when converted to_i' do
      expect(Weight.new(0.5, 'lb').to_i).to eq(1)
    end

    it 'should round 0.4 lbs to 0 lb when converted to_i' do
      expect(Weight.new(0.4, 'lb').to_i).to eq(0)
    end
  end

  describe 'comparison of different weights' do
    it 'two pounds should be more than one' do
      expect(Weight.new(2, :lb)).to be > one_lb
    end

    it 'two pounds should be greater than or equal to one plus one' do
      expect(Weight.new(2, :lb)).to be >= (one_lb + one_lb)
    end

    it 'one pound should be less than two' do
      expect(one_lb).to be < Weight.new(2, :lb)
    end

    it 'attempting to compare a weight to something that is not a weight should raise an error' do
      expect do
        (Weight.new(1, :lb) == 1)
      end.to raise_error(TypeError)
    end
  end
end