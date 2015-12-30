module Inflectors
  def camelcase
    self.to_s.gsub!(/(?:_|(\/))([a-z\d]*)/i) { $2.capitalize }
  end
end

[String, Object].each { |klass| klass.include(Inflectors) }
