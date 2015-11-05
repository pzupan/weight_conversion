require "weight_conversion/version"

class Weight

   def initialize(value=0.0, unit='lb')
      self.value = value
      self.unit = unit
   end

   def value
      @input_value
   end

   def unit
      @input_unit
   end

   def to_gms
      data_in_grams
   end

   def to_ozs
      data_in_grams / grams_per_ounce
   end

   def to_lbs
      data_in_grams / grams_per_pound
   end

   def to_i
      value.to_i
   end

   def to_f
      value.to_f
   end

   def +(other)
      return if is_not_weight?(other)
      self.class.new(value + other_value(other), unit)
   end

   def -(other)
      return if is_not_weight?(other)
      self.class.new(value - other_value(other), unit)
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
      [:gm, :oz, :lb]
   end

   def other_value(other)
      case unit
      when :gm
         other.to_gms
      when :oz
         other.to_ozs
      when :lb
         other.to_lbs
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

   def is_not_weight?(other)
      return false if other.is_a?(WeightConversion)
      raise TypeError, 'Not a WeightConversion class.'
      return true
   end

end
