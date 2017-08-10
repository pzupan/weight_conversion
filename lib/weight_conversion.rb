require "weight_conversion/version"
require 'i18n'

class Weight

   include Comparable

   def initialize(value=0.0, unit='lb')
      self.value = value
      self.unit = unit
   end

   def translated
    I18n.t("weight.units.#{unit}")
   end

   def value
      @input_value
   end

   def unit
      @input_unit
   end

   def to_gms
      data_in_grams.round(4)
   end

   def to_ozs
      (data_in_grams / grams_per_ounce).round(4)
   end

   def to_lbs
      (data_in_grams / grams_per_pound).round(4)
   end

   def to_kgs
      (data_in_grams / grams_per_kilogram).round(4)
   end

   def to_i
      value.round
   end

   def to_f
      value.round(4).to_f
   end

   def +(other)
      return if is_not_weight?(other)
      self.class.new(value + other_value(other), unit)
   end

   def -(other)
      return if is_not_weight?(other)
      self.class.new(value - other_value(other), unit)
   end

   def <=>(other)
      return if is_not_weight?(other)
      self.to_gms <=> other.to_gms
   end

   def ==(other)
      return if is_not_weight?(other)
      self.to_gms  == other.to_gms
   end

   def *(other)
      raise TypeError, 'You can only multiply by a number' unless other.is_a?(Numeric)
      self.class.new(value * other, unit)
   end

   def /(other)
      raise TypeError, 'You can only divide by a number' unless other.is_a?(Numeric)
      self.class.new(value / other, unit)
   end

   private

   def value=(value)
      raise TypeError, 'Value cannot be negative' if value < 0
      raise TypeError, 'Value must be Numeric' unless value.is_a? Numeric
      @input_value = value
   end

   def unit=(unit)
      unit = unit.to_s.downcase.to_sym
      raise ArgumentError, "Allowed unit types #{allowed_units.inspect}" unless allowed_units.include?(unit)
      @input_unit = unit
   end

   def allowed_units
      [:gm, :oz, :lb, :kg]
   end

   def other_value(other)
      case unit
      when :gm
         other.to_gms
      when :oz
         other.to_ozs
      when :lb
         other.to_lbs
      when :kg
         other.to_kgs
      end
   end

   def data_in_grams
      case unit
      when :gm
         value
      when :oz
         value * grams_per_ounce
      when :lb
         value * grams_per_pound
      when :kg
         value * grams_per_kilogram
      else
         raise TypeError, 'Unit is not valid.'
      end
   end

   def grams_per_ounce
      28.34952
   end

   def grams_per_pound
      453.5923
   end

   def grams_per_kilogram
      1000
   end

   def is_not_weight?(other)
      return false if other.is_a?(Weight)
      raise TypeError, 'Not a Weight class.'
      return true
   end

end
