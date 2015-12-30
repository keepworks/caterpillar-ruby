require 'httparty'

['caterpillar', 'core_ext'].each do |dir|
  Dir[File.dirname(__FILE__) + '/' + dir + '/*.rb'].each { |file| require file }
end

module Caterpillar
  class << self
    attr_accessor :api_key
    attr_accessor :api_version
    attr_accessor :base_uri

    def configure
      yield self
    end

    def create(source, options = {})
      raise CaterpillarError::NoApiKeyError.new('API Key is blank') if api_key.blank?
      raise CaterpillarError::NoSourceError.new('Source is blank') if source.blank?

      options = Hash[options.map { |key, value| [key.camelize, value] }]

      query = {
        source: source,
        data: {
          apiKey: api_key
        }.merge!(options)
      }

      HTTParty.post("#{base_uri}/#{api_version}/documents/pdf", query: query)
    end
  end
end
