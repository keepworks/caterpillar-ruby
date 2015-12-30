module Caterpillar
  APIError = Class.new(StandardError)
  NoApiKeyError = Class.new(RuntimeError)
  NoSourceError = Class.new(ArgumentError)
end
