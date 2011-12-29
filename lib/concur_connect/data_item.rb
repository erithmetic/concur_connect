module ConcurConnect
  class DataItem
    def initialize(attributes = {})
      attributes.each do |name, value|
        send "#{name}=", value
      end
    end
  end
end
