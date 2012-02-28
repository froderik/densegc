require 'date'

class TopTen
  def initialize key, number_of_results = 20
    @count_per_item = {}
    @key_to_data = key
    @number_of_results = number_of_results
  end

  def add data
    key_to_results = key_to_sort_on( data )
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
    (0...@number_of_results).each do |index|
      current = @sorted_counts[index]
      msg << current[0].to_s + ' : ' + current[1].to_s + "\n"
    end
    msg
  end

  def name 
    "Top #{@number_of_results} sorted on #{@key_to_data.to_s}"
  end
end


class TopTenMonths < TopTen
  def initialize
    super :date
  end

  def key_to_sort_on data
    date = data[:date]
    date.year.to_s + '-' + date.month.to_s
  end

  def name
    "Top ten sorted on month"
  end
end

class TopTenWeeks < TopTen
  def initialize
    super :date
  end

  def key_to_sort_on data
    date = data[:date]
    date.year.to_s + '-' + date.cweek.to_s
  end

  def name
    "Top ten sorted on week"
  end
end

class TopTenWeekDays < TopTen
  def initialize
    super :date, 7
  end

  def key_to_sort_on data
    date = data[:date]
    case date.wday
    when 1 then 'Monday'
    when 2 then 'Tuesday'
    when 3 then 'Wednesday'
    when 4 then 'Thursday'
    when 5 then 'Friday'
    when 6 then 'Saturday'
    when 0 then 'Sunday'
    end      
  end

  def name
    "Top ten sorted on week day"
  end
end

class Suite < TopTen
  def initialize number_of_days
    @number_of_days = number_of_days
    super :date, 1
  end

  def add data
    start_key_to_results = data[:date]
    (start_key_to_results-@number_of_days+1..start_key_to_results).each do |current_date|
      current = @count_per_item[current_date]
      if current.nil?
        @count_per_item[current_date] = 1
      else
        @count_per_item[current_date] = current.succ
      end
    end
  end
  
  def report 
    dates = @count_per_item.sort { |a,b| b[1] <=> a[1] }
    date = dates.first[0].to_s
    count = dates.first[1].to_s 
    "Best suite for #{@number_of_days} days started on #{date} with #{count} finds"
  end
end

