# AbebooksSWS

AbebooksSWS is a light-weight Ruby wrapper to the
[Abebooks SWS API][3]. It uses [Excon][1] to make requests and
[MultiXml][2] to parse the response.

Refer to [Abebooks SWS API End User Guide][3] for complete instructions

## Usage

### Setup

Set up a request:

A client key needs to be provided to make requests to SWS API

```ruby
req = AbebooksSWS.new({clientkey:ENV['CLIENT_KEY']})
```
### Request

Set up your parameters and make a request:

```ruby
params = {
  'isbn' => '0451161351'
}

res = req.perform(params)
```

### Response

The quick way to consume a response is to parse it into a Ruby hash:

```ruby
res.to_h
```

You can also pass the response body into a custom parser:

```ruby
MyParser.new(res.body)
```

### Getting results for a specific Abebooks domain

For example, to get results for abebooks.de you would make the request like this:

```ruby
# This parameters will return you the proper currency and shipping rates for Germany
params = {
  'isbn' => '0451161351'
  'currency' => 'EUR'
  'destinationcountry' => 'DEU'
}

res = req.perform(params)

# After getting a response it is necessary to transform the domain of the urls returned by the api
# from www.abebooks.com, to www.abebooks.de in this case.
# Doing this will parse the original response using MultiXML, if you want to achieve a similar
# result with a different parser you have to do it yourself.
results = res.convert_offer_urls('www.abebooks.de')
```

[1]: https://github.com/geemus/excon
[2]: https://github.com/sferik/multi_xml
[3]: http://www.abebooks.com/docs/AffiliateProgram/WebServices/end-user-guide.pdf
