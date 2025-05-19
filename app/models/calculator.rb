class Calculator
  def self.add(numbers)
    raise ArgumentError, "input should be a string" unless numbers.is_a?(String)
    numbers_array = numbers.split(/[\,\n]/)
    # raise ArgumentError, "upto 2 numbers allowed" unless numbers_array.size <= 2
    numbers_array.each do |number|
      raise ArgumentError, "Not a number" unless number.to_i.to_s == number
    end
    numbers_array.sum(&:to_i)
  end
end
