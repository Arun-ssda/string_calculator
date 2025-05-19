class Calculator
  def self.add(numbers)
    raise ArgumentError, "input should be a string" unless numbers.is_a?(String)
  end
end
