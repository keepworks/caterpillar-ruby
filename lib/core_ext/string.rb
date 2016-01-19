class String
  def is_caterpillar_json?
    JSON.parse(self)
  rescue
    false
  end
end
