class Counter
  def initialize 
    @count = 0
  end
  
  def add data
    @count = @count.succ
  end
  
  def report 
    "Count is " + @count.to_s
  end
end
