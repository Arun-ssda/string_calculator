class Calculator
  def self.add(numbers)
    raise ArgumentError, "input should be a string" unless numbers.is_a?(String)
    numbers_array = numbers.split(",")
    raise ArgumentError, "upto 2 numbers allowed" unless numbers_array.size <= 2
  end
end
