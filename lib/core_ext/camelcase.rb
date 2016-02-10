module Inflectors
  def camelcase
    string = self.to_s.downcase
    string.include?('_') ? string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { $2.capitalize.to_sym } : string.to_sym
  end
end

[String, Object].each { |klass| klass.include(Inflectors) }
