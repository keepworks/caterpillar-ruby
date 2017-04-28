require 'httparty'

['caterpillar-ruby', 'core_ext'].each do |dir|
  Dir[File.dirname(__FILE__) + '/' + dir + '/*.rb'].each { |file| require file }
end

module Caterpillar
  class << self
    attr_accessor :api_key
    attr_accessor :api_version
    attr_accessor :base_uri


    def configure
      @api_version = 'v1'
      @base_uri = 'https://api.caterpillar.io'

      yield self
    end

    def create(options = {})
      raise NoApiKeyError.new('API Key is blank') if api_key.blank?
      raise NoSourceError.new('Source is blank') if options[:source].blank?

      options.deep_modify_keys!(:camelize)

      query = {
        source: options.delete(:source),
        data: {
          apiKey: api_key
        }.merge!(options)
      }

      response = HTTParty.post("#{base_uri}/#{api_version}/documents/convert", query: query).force_encoding('ISO-8859-1').encode('UTF-8')

      parsed_response = response.is_caterpillar_json?
      raise APIError.new(parsed_response['message']) if parsed_response.present? && parsed_response['status'] == 0

      if block_given?
        return_value = nil

        Tempfile.open('caterpillar') do |f|
          f.sync = true
          f.write(response)
          f.rewind

          return_value = yield f, response
        end

        return_value
      else
        response
      end
    end
  end
end
