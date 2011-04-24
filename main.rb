
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

MyFindsStatisticsGenerator.new().generate 