# Method to calculate factorial sequentially
def factorial_sequential(n)
  result = 1
  (2..n).each { |i| result *= i }
  result
end

# Method to calculate factorial using Ractors
def factorial_parallel(n, num_ractors)
  chunk_size = (n / num_ractors).ceil
  results = []

  num_ractors.times do |i|
    start_num = i * chunk_size + 1
    end_num = [start_num + chunk_size - 1, n].min

    ractor = Ractor.new(start_num, end_num) do |start_num, end_num|
      result = 1
      (start_num..end_num).each { |i| result *= i }
      result
    end

    results << ractor
  end

  results.map(&:take).inject(:*)
end

# Number to calculate factorial
number = 100000

# Calculate factorial sequentially
start_time_sequential = Time.now
result_sequential = factorial_sequential(number)
end_time_sequential = Time.now
puts "Sequential factorial of #{number}:"
puts "Sequential processing time: #{end_time_sequential - start_time_sequential} seconds"

# Calculate factorial using Ractors
num_ractors = 200 # Number of Ractors to use
start_time_parallel = Time.now
result_parallel = factorial_parallel(number, num_ractors)
end_time_parallel = Time.now
puts "Parallel factorial of #{number}:"
puts "Parallel processing time: #{end_time_parallel - start_time_parallel} seconds"
