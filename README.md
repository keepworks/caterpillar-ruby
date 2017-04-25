# Caterpillar-Ruby

This Ruby gem is a simple wrapper around the Caterpillar API. [Caterpillar](https://caterpillar.io) is a web service that allows you to convert html to pdf.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'caterpillar-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caterpillar-ruby

## Usage

Set the following attributes in you Ruby app:

```
Caterpillar.api_key = 'YOUR_CATERPILLAR_API_KEY'
Caterpillar.api_version =  'v1'
Caterpillar.base_uri = 'https://api.caterpillar.io'
```

For a Rails app you can execute:

    $ rails generate caterpillar:install

or create an initializer `config/initializers/caterpillar.rb` yourself and set custom values:

```
Caterpillar.configure do |config|
  config.api_key = 'YOUR_CATERPILLAR_API_KEY' #Required
  config.api_version = 'YOUR_API_VERSION'
  config.base_uri = 'YOUR_API_BASE_URI'
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
  #response is the HTTParty response object
end
```

`create` will return an [HTTParty](https://github.com/jnunemaker/httparty) response object, which will be the new file (or errors, if the request was not valid).

The only **required parameter** is:
  * `:source` - a string containing the HTML or URL for creating the document

For a Rails app you can pass a view as source by converting it to an HTML string using [render_to_string](http://apidock.com/rails/ActionController/Base/render_to_string).

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
`:password_protect` | `Hash` | Refer next section for more details

## Password Protect
You can password protect PDF using AES 256, AES 128, RC4 (128 & 40) encryption algorithms supported by Adobe Reader.

To encrypt PDF you need to pass `:password_protect` hash in the `create` method call along with the following **required parameters**:
* `:password` - a string containing the secret password which will be further used to unlock the PDF
* `:key_length` - a number which defines the encryption algorithm to be used. Values can be **40, 128 and 256** only.

You might want to set other options for each encryption algorithm inside `:restrictions` hash:

*Key Length:* **40**

| Option | Value | Description |
|:---|:---|:---|
`:print` | `'y', 'n'` | Determines whether or not to allow printing.
`:modify` | `'y', 'n'` | Determines whether or not to allow document modification.
`:extract` | `'y', 'n'` | Determines whether or not to allow text/image extraction.
`:annotate` | `'y', 'n'` | Determines whether or not to allow comments and form fill-in and signing.

*Key Length:* **128**

| Option | Value | Description |
|:---|:---|:---|
`:print` | `'full', 'low', 'none'` | **full**: allow full printing. **low**: allow low-resolution printing only. **none**: disallow printing.
`:modify` | `'all', 'annotate', 'form', 'assembly', 'none'` | **all:** allow full document modification. **annotate:** allow comment authoring and form operations. **form:** allow form field fill-in and signing. **assembly:** allow document assembly only. **none:** allow no modifications.
`:extract` | `'y', 'n'` | Determines whether or not to allow text/image extraction.
`:use_aes` | `'y', 'n'` | AES encryption will be used instead of RC4 encryption.
`:accessibility` | `'y', 'n'` | Determines whether or not to allow accessibility to visually impaired.

*Key Length:* **256**

| Option | Value | Description |
|:---|:---|:---|
`:print` | `'full', 'low', 'none'` | **full**: allow full printing. **low**: allow low-resolution printing only. **none**: disallow printing.
`:modify` | `'all', 'annotate', 'form', 'assembly', 'none'` | **all:** allow full document modification. **annotate:** allow comment authoring and form operations. **form:** allow form field fill-in and signing. **assembly:** allow document assembly only. **none:** allow no modifications.
`:extract` | `'y', 'n'` | Determines whether or not to allow text/image extraction.
`:accessibility` | `'y', 'n'` | Determines whether or not to allow accessibility to visually impaired.

**Example:**
```
Caterpillar.create(
    source: content,
    password_protect: {
        password: 'YOUR_PASSWORD_HERE',
        key_length: 128,
        restrictions: {
            print: 'low',
            use_aes: 'y'
        }
    }
)
```

## Meta

Maintained by [KeepWorks](http://www.keepworks.com/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keepworks/caterpillar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
