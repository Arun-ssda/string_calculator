class Calculator
  def self.get_delimiters(numbers)
    numbers.match?(/\/\/\[.*\]\n/) ? numbers.match(/\/\/\[(.*)\]+\n/)[1].split("][") : [ "," ]
  end

  def self.get_numbers(numbers)
    numbers.match?(/\/\/\[.*\]\n/) ? numbers.split("\n", 2).last : numbers
  end

  def self.check_for_negatives!(numbers_array)
    negatives = numbers_array.select { |number| number.to_i < 0 }
    raise ArgumentError, "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?
  end

  def self.add(numbers)
    raise ArgumentError, "input should be a string" unless numbers.is_a?(String)
    delimiters = get_delimiters(numbers)
    delimiters << "\n" unless delimiters.include?("\n")
    regex_to_split = Regexp.new(delimiters.map { |delimiter| Regexp.escape(delimiter) }.join("|"))
    numbers = get_numbers(numbers)
    numbers_array = numbers.split(regex_to_split)
    # raise ArgumentError, "upto 2 numbers allowed" unless numbers_array.size <= 2
    check_for_negatives!(numbers_array)
    numbers_array.each do |number|
      raise ArgumentError, "Not a number" unless number.to_i.to_s == number
    end
    numbers_array.reject! { |number| number.to_i > 1000 }
    numbers_array.sum(&:to_i)
  end
end
