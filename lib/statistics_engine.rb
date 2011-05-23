class StatisticsEngine

  def initialize
    @data = []
  end
  
  def add hash
    @data << hash
  end
  
  def count
    @data.size
  end
  
end