=begin
result on ruby 1.9.3
dots4 :   1624 patterns :   0.011 seconds
dots5 :   7152 patterns :   0.053 seconds
dots6 :  26016 patterns :   0.221 seconds
dots7 :  72912 patterns :   0.715 seconds
dots8 : 140704 patterns :   1.789 seconds
dots9 : 140704 patterns :   3.165 seconds
-----------------------------------------
total : 389112 patterns :   5.954 seconds
=end

class CountLockingPattern
  def initialize()
    @count = 0
  end
  
  def count_dots_all_patterns
    total_count = 0
    total_time = 0
    for i in 4 .. 9
      time = count_dots_n_patterns(i)
      total_count += @count
      total_time += time
    end
    puts "-----------------------------------------"
    puts "total : #{sprintf("%6d", total_count)} "\
         "patterns : #{sprintf("%7.3f", total_time)} seconds"
  end

  def count_dots_n_patterns(n)
    @count = 0
    before = Time.now
    count_recursive(n, [])
    time = Time.now - before
    puts "dots#{n} : #{sprintf("%6d", @count)} "\
         "patterns : #{sprintf("%7.3f", time)} seconds"
    time
  end

  def count_recursive(n, arr)
    for i in 1 .. 9
      next if arr.include?(i)
      arr.push(i)
      if valid?(arr.join(""))
        if n == 1
          @count += 1
        else
          count_recursive(n - 1, arr)
        end
      end
      arr.pop
    end
  end

  # Judge if str has NG patterns
  def valid?(str)
    if str =~ /^([^2]*(13|31)|[^4]*(17|71)|[^6]*(39|93)|[^8]*(79|97)|
               [^5]*(46|64|28|82|19|91|37|73)).*\z/x
      false
    else
      true
    end
  end
end

def main
  clp = CountLockingPattern.new
  if ARGV.size == 0
    clp.count_dots_all_patterns()
  else
    clp.count_dots_n_patterns(ARGV[0].to_i)
  end
end

main
