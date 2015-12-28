require 'caterpillar/version'
require 'httparty'

module Caterpillar
  class << self
    attr_accessor :api_key

    def configure
      yield self
    end
  end
end
