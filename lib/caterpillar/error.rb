module CaterpillarError
  class NoApiKeyError < RuntimeError; end
  class NoSourceError < ArgumentError; end
end
