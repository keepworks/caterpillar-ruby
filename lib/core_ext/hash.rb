class Hash
  def deep_modify_keys(modification = :symbolize)
    if modification == :camelize
      Hash[
        self.map do |key, value|
          [key.to_camelcase.to_sym, value.is_a?(Hash) ? value.deep_modify_keys(:camelize) : value]
        end
      ]
    elsif modification == :underscorize
      Hash[
        self.map do |key, value|
          [key.to_underscore.to_sym, value.is_a?(Hash) ? value.deep_modify_keys(:underscorize) : value]
        end
      ]
    else
      Hash[self.map { |key, value| [key.to_sym, value.is_a?(Hash) ? value.deep_modify_keys : value] }]
    end
  end

  def deep_modify_keys!(modification = :symbolize)
    self.replace(deep_modify_keys(modification))
  end
end
