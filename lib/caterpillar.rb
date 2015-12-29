require 'httparty'

['caterpillar', 'core_ext'].each do |dir|
  Dir[File.dirname(__FILE__) + '/' + dir + '/*.rb'].each { |file| require file }
end

class Caterpillar
  include HTTParty

  class << self
    attr_accessor :api_key
    attr_accessor :api_version

    def configure
      yield self
    end

    def create(options = {})
      raise CaterpillarError::NoApiKeyError.new('API Key is blank') if api_key.blank?
      raise CaterpillarError::NoSourceError.new('Source is blank') if options[:source].blank?
    end
  end

  self.api_version ||= 'v1'
  base_uri 'https://api.caterpillar.io/' + self.api_version
end
