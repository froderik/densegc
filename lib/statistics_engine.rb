class StatisticsEngine

  def initialize
    @handlers = []
  end
  
  def add hash
    @handlers.each { |h| h.add hash }
  end
  
  def add_handler handler
    @handlers << handler
  end
  
  def count
    @data.size
  end
  
  def report 
    msg = @handlers.size.to_s + " handlers have processed the data\n"
    @handlers.each do |h|
      msg << h.report
    end
    msg
  end
  
end