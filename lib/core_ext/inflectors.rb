module Inflectors
  def to_camelcase
    string = self.to_s.downcase
    string.include?('_') ? string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { $2.capitalize.to_sym } : string.to_sym
  end

  def to_underscore
    self.to_s.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').tr('-', '_').downcase
  end
end

[String, Object].each { |klass| klass.include(Inflectors) }
