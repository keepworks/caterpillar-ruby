require 'httparty'

['caterpillar', 'core_ext'].each do |dir|
  Dir[File.dirname(__FILE__) + '/' + dir + '/*.rb'].each { |file| require file }
end

module Caterpillar
  def validate_json(json)
    JSON.parse(json)
  rescue
    false
  end
  class << self
    attr_accessor :api_key
    attr_accessor :api_version
    attr_accessor :base_uri

    def configure
      yield self
    end

    def create(source, options = {})
      raise NoApiKeyError.new('API Key is blank') if api_key.blank?
      raise NoSourceError.new('Source is blank') if source.blank?

      options = Hash[options.map { |key, value| [key.camelcase, value] }]

      query = {
        source: source,
        data: {
          apiKey: api_key
        }.merge!(options)
      }

      response = HTTParty.post("#{base_uri}/#{api_version}/documents/pdf", query: query)

      parsed_response = response.is_caterpillar_json?
      raise APIError.new(parsed_response['message']) if parsed_response.present? && parsed_response['status'] == 0

      response
    end
  end
end
