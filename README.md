# Caterpillar-Ruby

This Ruby gem is a simple wrapper around the Caterpillar API. [Caterpillar](https://caterpillar.io) is a web service that allows you to convert html to pdf.

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
  config.base_uri = 'https://api.caterpillar.io'
end
```

Once set, you can create a PDF document by calling:

```
Caterpillar.create(source: content, grayscale: true, no_images: true)
```

You can also create test PDF documents by calling (header and footer options donot work in test mode):

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

`create` will return an [HTTParty](https://github.com/jnunemaker/httparty) response object, which will be the new file (or errors, if the request was not valid).

The only required parameter is:
  * `:source` - a string containing the HTML or URL for creating the document

You might want to set other options in that hash:

| Option | Type | Description |
|:---|:---|:---|
`:copies` | `Number` | Number of copies to print into the pdf
`:grayscale` | `Boolean` | PDF will be generated in grayscale
`:margin_bottom` | `Number` | Set the page bottom margin
`:margin_left` | `Number` | Set the page left margin (default 10mm)
`:margin_right` | `Number` | Set the page right margin (default 10mm)
`:margin_top` | `Number` | Set the page top margin
`:orientation` | `String` | Set orientation to Landscape or Portrait (default Portrait)
`:page_size` | `String` | Set paper size to: A4, Letter, etc. (default A4)
`:background` | `Boolean` | Do print background (default true)
`:no_background` | `Boolean` | Do not print background
`:disable_external_links` | `Boolean` | Do not make links to remote web pages
`:enable_external_links` | `Boolean` | Make links to remote web pages (default true)
`:disable_forms` | `Boolean` | Do not turn HTML form fields into pdf form fields (default true)
`:enable_forms` | `Boolean` | Turn HTML form fields into pdf form fields
`:images` | `Boolean` | Do load or print images (default true)
`:no_images` | `Boolean` | Do not load or print images
`:disable_internal_links` | `Boolean` | Do not make local links
`:enable_internal_links` | `Boolean` | Make local links (default true)
`:disable_javascript` | `Boolean` | Do not allow web pages to run javascript
`:enable_javascript` | `Boolean` | Do allow web pages to run javascript (default true)
`:javascript_delay` | `Number` | Wait some milliseconds for javascript finish (default 200)
`:viewport_size` | `String` | Set viewport size if you have custom scrollbars or css attribute overflow to emulate window size
`:zoom` | `Number` | Use this zoom factor (default 1)
`:footer_center` | `Number`/`String` | Centered footer text
`:footer_font_name` | `Number`/`String` | Set footer font name (default Arial)
`:footer_font_size` | `Number`/`String` | Set footer font size (default 12)
`:footer_html` | `String` | Adds a html footer
`:footer_left` | `Number`/`String` | Left aligned footer text
`:footer_line` | `Boolean` | Display line above the footer
`:no_footer_line` | `Boolean` | Do not display line above the footer (default true)
`:footer_right` | `Number`/`String` | Right aligned footer text
`:footer_spacing` | `Number` | Spacing between footer and content in mm (default 0)
`:header_center` | `Number`/`String` | Centered header text
`:header_font_name` | `Number`/`String` | Set header font name (default Arial)
`:header_font_size` | `Number`/`String` | Set header font size (default 12)
`:header_html` | `String` | Adds a html header
`:header_left` | `Number`/`String` | Left aligned header text
`:header_line` | `Boolean` | Display line below the header
`:no_header_line` | `Boolean` | Do not display line below the header (default true)
`:header_right` | `Number`/`String` | Right aligned header text
`:header_spacing` | `Number` | Spacing between header and content in mm (default 0)

## Meta

Maintained by [KeepWorks](http://www.keepworks.com/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keepworks/caterpillar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
