require 'spec_helper'

describe Weight do

  let(:one_kg) { Weight.new(1, :kg) }
  let(:one_lb) { Weight.new(1, :lb) }
  let(:one_oz) { Weight.new(1, :oz) }
  let(:one_gm) { Weight.new(1, :gm) }

  it 'should take two options value and unit type' do
    Weight.new(1, :lb).should be_instance_of(Weight)
  end

  describe 'math operators' do
    it 'for minus operator result unit should be equal to first object unit' do
      (one_kg - one_lb).unit.should == :kg
    end

    it 'for plus operator result unit should be equal to first object unit' do
      (one_kg + one_lb).unit.should == :kg
    end

    it 'minus operator should compute weight objects with different units properly' do
      (one_kg - one_lb).should > one_lb
      (one_lb - one_oz).should < one_lb
    end

    it 'plua operator should compute weight objects with different units properly' do
      (one_gm + one_oz).should < one_lb
      (one_oz + one_lb).should > one_lb
    end

    it 'plus operator should have proper result' do
      (one_lb + one_lb).should == Weight.new(2, :lb)
    end

    it 'two objects with the same weight and type should be equal' do
      one_kg.should == Weight.new(1, :kg)
    end

    it 'operation resulting in zero is okay' do
      (one_lb - one_lb).should == Weight.new(0, :lb)
    end

    it 'times operator should have proper result' do
      (one_lb * 2).should == Weight.new(2, :lb)
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
      (one_kg * 2).should == Weight.new(2, :kg)
    end

    it 'division should have proper result' do
      (Weight.new(2, :kg) / 2).should == one_kg
    end

    it 'attempting to divide a weight by another weight should raise an error' do
      expect do
        (one_lb / one_lb)
      end.to raise_error(TypeError)
    end
  end

  describe 'calculation between different units' do
    it 'should convert 1 kg to 2.2046 lbs' do
      Weight.new(1, :kg).to_lbs.should == 2.2046
    end

    it 'should convert 1 lbs to 0.45359 kg' do
      Weight.new(1, :lb).to_kgs.should == 0.4536
    end

    it 'should convert 1 kg to 35.2740 ounces' do
      Weight.new(1, :kg).to_ozs.should == 35.2740
    end

    it 'should convert 1 kg to 1000 grams' do
      Weight.new(1, :kg).to_gms.should == 1000
    end

    it 'should convert 1000 gms to 1 kg' do
      Weight.new(1000, :gm).to_kgs.should == 1
    end

    it 'should convert 28.3495 gms to 1 oz' do
      Weight.new(28.3495, :gm).to_ozs.should == 1
    end

    it 'should convert 453.5923 gms to 1 lb' do
      Weight.new(453.5923, :gm).to_lbs.should == 1
    end

    it 'should convert 0 kgs to 0 lb' do
      Weight.new(0, 'kg').to_lbs.should == 0.0
    end

    it 'should raise an error when the weight is negative' do
      expect do
        Weight.new(-1, 'kg')
      end.to raise_error(TypeError)
    end

    it 'should return the weight in pounds when converted to_f' do
      Weight.new(0.6, 'lb').to_f.should == 0.6
    end

    it 'should round 0.6 lbs to 1 lb when converted to_i' do
      Weight.new(0.6, 'lb').to_i.should == 1
    end

    it 'should round 0.5 lbs to 1 lb when converted to_i' do
      Weight.new(0.5, 'lb').to_i.should == 1
    end

    it 'should round 0.4 lbs to 0 lb when converted to_i' do
      Weight.new(0.4, 'lb').to_i.should == 0
    end
  end

  describe 'comparison of different weights' do
    it 'two pounds should be more than one' do
      Weight.new(2, :lb).should be > one_lb
    end

    it 'two pounds should be greater than or equal to one plus one' do
      Weight.new(2, :lb) >= one_lb + one_lb
    end

    it 'one pound should be less than two' do
      one_lb.should be < Weight.new(2, :lb)
    end

    it 'attempting to compare a weight to something that is not a weight should raise an error' do
      expect do
        (Weight.new(1, :lb) == 1)
      end.to raise_error(TypeError)
    end
  end
end