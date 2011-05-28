require 'date'

class TopTen
  def initialize key
    @count_per_item = {}
    @key_to_data = key
  end
  
  def add data
    key_to_results = key_to_sort_on data 
    current = @count_per_item[key_to_results]
    if current.nil?
      @count_per_item[key_to_results] = 1
    else
      @count_per_item[key_to_results] = current.succ
    end
  end
  
  def key_to_sort_on data
    data[@key_to_data]
  end
  
  def report
    @sorted_counts = @count_per_item.sort { |a,b| b[1] <=> a[1] }
    msg = name + "\n"
    (0...10).each do |index|
      current = @sorted_counts[index]
      msg << current[0].to_s + ' : ' + current[1].to_s + "\n"
    end
    msg
  end
  
  def name 
    "Top ten sorted on " + @key.to_s
  end
end


class TopTenMonths < TopTen
  def initialize
    super :date
  end
  
  def key_to_sort_on data
    date = data[:date]
    date.year.to_s + date.month.to_s
  end
  
  def name
    "Top ten sorted on month"
  end
end

