require "byebug"

def bsearch(array, target)
  middle = array.length / 2

  case array[middle] <=> target
  when -1
    search = bsearch(array.dup.drop(middle + 1), target)
    return search if search.nil?
    return search + middle + 1
  when 0
    return middle
  when 1
    return bsearch(array.dup.take(middle), target)
  end
end

puts '----------binary search-----------'
puts bsearch([1, 3, 4, 5, 6], 6) == 4
puts bsearch([1, 3, 4, 5, 6], 3) == 1
puts bsearch([1, 3, 4, 5, 6], 4) == 2

# return the first n fibonacci numbers in an array
def rec_fib(n)
  return [1] if n == 1
  return [1, 1] if n == 2
  fibs = rec_fib(n - 1)
  fibs << (fibs[-1] + fibs[-2])
end

p "---------rec fib---------"
p rec_fib(5) == [1, 1, 2, 3, 5]

# return recursively all subsets of an array
class Array
  def rec_subsets
    return [[]] if empty?

    subs = self.take(length - 1).rec_subsets
    subs.concat(subs.map { |el| el + [last] })
  end
end

p "----------recursive subsets----------"
p [1, 2, 3].rec_subsets == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# Two Sum
#
# Write a new `Array#two_sum` method that finds all pairs of positions
# where the elements at those positions sum to zero.
#
# NB: ordering matters. I want each of the pairs to be sorted smaller
# index before bigger index. I want the array of pairs to be sorted
# "dictionary-wise":
#
# ```ruby
# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# ```
#
# * `[0, 2]` before `[1, 2]` (smaller first elements come first)
# * `[0, 1]` before `[0, 2]` (then smaller second elements come first)
class Array
  def two_sum
    pairs = []

    self.each_with_index do |num, idx|
      j = idx + 1
      while j < self.length
        pairs << [idx, j] if num + self[j] == 0
        j += 1
      end
    end
    pairs
  end
end

p "----------two sum----------"
p [-1, 0, 2, -2, 1].two_sum == [[0, 4], [2, 3]]

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  2.upto(num / 2) do |n|
    return false if num % n == 0
  end
  true
end

def primes(num)
  prime_nums = []

  i = 2
  until prime_nums.length == num
    prime_nums << i if is_prime?(i)
    i += 1
  end

  prime_nums
end

p "----------primes----------"
p is_prime?(257) == true
p is_prime?(2) == true
p is_prime?(4) == false
p is_prime?(13) == true
p is_prime?(40) == false
p primes(7) == [2, 3, 5, 7, 11, 13, 17]

## uses recursion to calculate the sum from 1 to n (inclusive of n)
def sum_to(n)
  return nil if n < 1
  return 1 if n == 1
  sum_to(n - 1) + n
end

p "----------sum to----------"
p sum_to(5) == 15  # => returns 15
p sum_to(1) == 1  # => returns 1
p sum_to(9) == 45  # => returns 45
p sum_to(-8) == nil  # => returns nil

## takes in an array of Fixnums and returns the sum of those numbers

def add_numbers(nums_array)
  nums_array.inject { |sum, el| sum + el }
end

p "----------add numbers----------"
p add_numbers([1,2,3,4]) == 10 # => returns 10
p add_numbers([3]) == 3 # => returns 3
p add_numbers([-80,34,7]) == -39 # => returns -39
p add_numbers([]) == nil # => returns nil

## solve gamma function recursively
## gamma(n) (n - 1)!

def gamma_fnc(num)
  return nil if num < 1
  return 1 if num == 1
  (num - 1) * gamma_fnc(num - 1)
end

p "----------gamma function----------"
p gamma_fnc(0) == nil # => returns nil
p gamma_fnc(1) == 1  # => returns 1
p gamma_fnc(4) == 6  # => returns 6
p gamma_fnc(8) == 5040  # => returns 5040

## recursively find out whether the shop offers the favorite flavor

def ice_cream_shop(flavors, favorite)
  return false if flavors.empty?
  return true if flavors.first == favorite
  ice_cream_shop(flavors[1..-1], favorite)
end

p "--------ice cream shop---------"
p ice_cream_shop(["mint", "chocolate", "vanilla"], "vanilla") == true
p ice_cream_shop(["mint", "chocolate", "vanilla"], "sherbet") == false
p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon') == false  # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea') == true  # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio') == false  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks') == true  # => returns true
p ice_cream_shop([], 'honey lavender') == false  # => returns false

## takes in a string and returns it reversed recursively
def rec_reverse(string)
  return string if string.length < 1
  rec_reverse(string[1..-1]) + string[0]
end

p "--------recursive reverse-------"
p rec_reverse("hello") == "olleh"
p rec_reverse("house") == "esuoh" # => "esuoh"
p rec_reverse("dog") == "god" # => "god"
p rec_reverse("atom") == "mota" # => "mota"
p rec_reverse("q") == "q" # => "q"
p rec_reverse("id") == "di" # => "di"
p rec_reverse("") == "" # => ""

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  facs = factorials_rec(num - 1)
  facs << facs[-1] * (num - 1)
end

p "---------factorials recursion---------"
p factorials_rec(6) == [1, 1, 2, 6, 24, 120]
p factorials_rec(1) == [1]

#rec
def permutations(array)
  return [array] if array.length <= 1

  perms = []
  first = array.first
  prev_perm = permutations(array[1..-1])

  prev_perm.each do |arr|
    i = 0
    while i <= arr.length
      perms << arr.dup.insert(i, first)
      i += 1
    end
  end

  perms.sort
end

p "---------permutations-----------"
p permutations([1, 2, 3]) == [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]

class Array

  def deep_dup
    out = []

    self.each do |el|
      if el.is_a?(Array)
        out << el.deep_dup
      else
        out << el
      end

      out
    end

  end

p "------------deep dup-------------"
p [1, 2, [3, 4, [5]]].deep_dup == [1, 2, [3, 4, [5]]]

  # My Transpose
  #
  # To represent a *matrix*, or two-dimensional grid of numbers, we can
  # write an array containing arrays which represent rows:
  #
  # ```ruby
  # rows = [
  #     [0, 1, 2],
  #     [3, 4, 5],
  #     [6, 7, 8]
  #   ]
  #
  # row1 = rows[0]
  # row2 = rows[1]
  # row3 = rows[2]
  # ```
  #
  # We could equivalently have stored the matrix as an array of
  # columns:
  #
  # ```ruby
  # cols = [
  #     [0, 3, 6],
  #     [1, 4, 7],
  #     [2, 5, 8]
  #   ]
  # ```
  #
  # Write a method, `my_transpose`, which will convert between the
  # row-oriented and column-oriented representations. You may assume square
  # matrices for simplicity's sake. Usage will look like the following:
  #
  # ```ruby
  # matrix = [
  #   [0, 1, 2],
  #   [3, 4, 5],
  #   [6, 7, 8]
  # ]
  #
  # matrix.my_transpose
  #  # => [[0, 3, 6],
  #  #    [1, 4, 7],
  #  #    [2, 5, 8]]
  # ```
  #
  # Don't use the built-in `transpose` method!

  def my_transpose
    transposed = []

    i = 0
    until transposed.length == length
      current = []
      self.each do |arr|
        current << arr[i]
      end
      i += 1
      transposed << current
    end

    transposed
  end

matrix = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
]

p "----------my transpose---------"
p matrix.my_transpose == [[0, 3, 6], [1, 4, 7], [2, 5, 8]]

  # find median of an array, if it's an even number of els in array
  # add middle two elements together
  # sorted array

  def median
    sorted = self.dup.sort

    result = 0

    middle = length / 2
    if sorted.length.odd?
      return self.take(middle + 1).last
    else
      return (self.drop(middle).first + self.take(middle).last)/2.0
    end
  end

  p "--------median--------"
  p [1, 2, 3, 4].median == 2.5
  p [1, 2, 3, 4, 5].median == 3

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    dup_hash = Hash.new { |h, k| h[k] = [] }

    self.each_with_index do |el, idx|
      dup_hash[el] << idx
    end

    dup_hash.select { |k, v| v.length > 1 }
  end

  p "--------dups-------"
  p [1, 3, 4, 3, 0, 3, 0].dups == { 3 => [1, 3, 5], 0 => [4, 6] }

  def my_quick_sort(&prc)
    return self if length < 2
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = self.first

    left = self[1..-1].select { |el| prc.call(el, pivot) == -1 }
    right = self[1..-1].select { |el| prc.call(el, pivot) != -1 }

    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end

  p "---------quicksort--------"
  p [34, 2, 3, 123, 34, 54, 27].my_quick_sort == [2, 3, 27, 34, 34, 54, 123]

  def my_each(&prc)
    prc ||= Proc.new { |el| el }

    self.length.times do |i|
      prc.call(self[i])
    end
    self
  end

  def my_none?(&prc)
    self.my_each do |el|
      return false if prc.call(el) == true
    end
    true
  end

  p "----------my_none---------"
  p [1, 2, 3].my_none? { |el| el == 3 } == false

  def my_inject(accumulator = nil, &prc)
    prc ||= Proc.new { |accumulator, num| accumulator + num }
    i = 0
    if accumulator.nil?
      accumulator = self[i]
      i += 1
    end

    while i < self.length
      accumulator = prc.call(accumulator, self[i])
      i += 1
    end
    accumulator
  end

  p "--------inject--------"
  p [1, 2, 3, 4, 5, 10].my_inject == 25

  def my_each_with_index(&prc)
    self.length.times do |i|
      prc.call(self[i], i)
    end

    self
  end

  def my_map(&prc)
    mapped = []
    self.my_each do |el|
      mapped << prc.call(el)
    end
    mapped
  end

  def my_select(&prc)
    selected = []
    self.my_each do |el|
      selected << el if prc.call(el)
    end
    selected
  end

  def my_reject(&prc)
    rejected = []
    self.my_each do |el|
      rejected << el unless prc.call(el)
    end
    rejected
  end

  def my_any?(&prc)

  end

  def my_all?(&prc)

  end

  def my_flatten
    flattened = []
    self.each do |el|
      if el.is_a?(Array)
        flattened.concat(el.my_flatten)
      else
        flattened << el
      end
    end
    flattened
  end

  p "----------flatten---------"
  p [1, 2, [3, [4, 5, [6, 7], 8], 9], 10].my_flatten == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  def my_bsearch(target)
    return nil if self.empty?
    middle = self.length / 2

    case self[middle] <=> target
    when -1
      return self.dup.drop(middle).my_bsearch(target) + middle
    when 0
      return middle
    when 1
      return self.dup.take(middle).my_bsearch(target)
    end

  end

  p "--------bsearch--------"
  p [1, 2, 3, 4, 5, 6, 7].my_bsearch(6) == 5
  p [1, 2, 3, 4, 5, 6, 7].my_bsearch(2) == 1

  def my_zip(*args)
    zipped = []

    self.my_each do |el|
      zipped << [el]
    end

    args.my_each do |el|
      i = 0
      while i < self.length
        zipped[i] << el[i]
        i += 1
      end
    end

    zipped
  end

  def my_rotate(rotation = 1)
    result = self.dup

    rotation.times do |i|
      result << result.shift
    end
    result
  end

  def my_bubble_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    result = self.dup

    sorted = false

    until sorted
      sorted = true
      i = 0
      while i < self.length - 1
        j = i + 1
        if prc.call(result[i], result[j]) == 1
          sorted = false
          result[i], result[j] = result[j], result[i]
        end
        i += 1
      end
    end
    result
  end

  p "---------bubble sort----------"
  p [1, 2, 3, 22, 22, 11, 23, 7, 45].my_bubble_sort == [1, 2, 3, 7, 11, 22, 22, 23, 45]

  def my_join(separator = "")
    result = ""
    self.each do |el|
      result << el.to_s
      result << separator
    end
    result
  end

  def my_reverse

  end

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return self if length <= 1

    midpoint = self.length / 2
    left = self.take(midpoint).merge_sort(&prc)
    right = self.drop(midpoint).merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  # private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)
  end

end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    subs = []

    self.each_char.with_index do |char, i|
      j = i + 1
      while j < self.length
        subs << self[i..j] if self[i..j].palindrome?
        j += 1
      end
    end
    subs
  end

  def palindrome?
    return false if self.length < 2
    return true if self == self.reverse
  end

  def substrings
    subs = []

    self.each_char.with_index do |char, i|
      j = 0
      while j < self.length
        subs << self[i..j]
        j += 1
      end
    end
    subs.uniq
  end

end

### Binary to Base 10
#
# Write a method that given a string representation of a binary number will
# return that binary number in base 10.
#
# To convert from binary to base 10, we take the sum of each digit multiplied by
# two raised to the power of its index. For example:
#   1001 = [ 1 * 2^3 ] + [ 0 * 2^2 ] + [ 0 * 2^1 ] + [ 1 * 2^0 ] = 9
#
# You may NOT use the Ruby String class's built in base conversion method.

def base2to10(str_num)
  str = str_num.dup.reverse
  total = 0

  str.each_char.with_index do |char, idx|
    total += (char.to_i * (2 ** idx))
  end
  total
end

puts "-------Binary to Base 10-------"
puts base2to10("10") == 2
puts base2to10("01") == 1
puts base2to10("0111") == 7
puts base2to10("1100") == 12
puts base2to10("1010101") == 85

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  return str.split("").sort.join if alphabet.nil?
  #not done yet
end

def digital_root(num)
  return num if num <= 10
  num % 9
end

def digital_root(num)
   return num if num < 10
   digital_root((num / 10) + (num % 10))
 end
