# Caterpillar-Ruby

This Ruby gem is a simple wrapper around the Caterpillar API. Caterpillar is a web service that allows you to convert html to pdf.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'caterpillar_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caterpillar_ruby

## Usage

Set the following attributes in you Ruby app:

```
Caterpillar.api_key = 'YOUR_CATERPILLAR_API_KEY'
Caterpillar.api_version =  'v1'
Caterpillar.base_uri = 'https://api.caterpillar.io'
```

For a Rails app you can execute:

    $ rails generate caterpillar_ruby:install

or create an initializer `config/initializers/caterpillar.rb`

```
Caterpillar.configure do |config|
  config.api_key = 'YOUR_CATERPILLAR_API_KEY'
  config.api_version = 'v1'
  config.base_uri = 'https://caterpillar.io/api'
end
```

Once set, you can create a PDF document by calling:

```
Caterpillar.create(source: content, test: true)
```

The `create` call can also take a block, like so:

```
Caterpillar.create(source: content) do |file, response|
  #file is a tempfile holding the response body
  #reponse is the HTTParty response object
end
```

The only required parameter is:
  * `:source` - a string containing the HTML or URL for creating the document

You might want to set other options in that hash:

`create` will return an [HTTParty](https://github.com/jnunemaker/httparty) response object, which will be the new file (or errors, if the request was not valid).

## Meta

Maintained by [KeepWorks](http://www.keepworks.com/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keepworks/caterpillar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
