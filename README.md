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
req = SWS.new(ENV['CLIENT_KEY'])
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

### Getting results for a specific Abebooks country

For example, to get results for abebooks.de you would make the request like this:

```ruby
# This parameters will return you the proper currency and shipping rates for Germany
params = {
  'isbn' => '0451161351'
  'currency' => 'EUR'
  'destinationcountry' => 'DEU'
}

res = SWS.new(ENV['CLIENT_KEY']).perform(params)
```

If you intend to get offer urls for a particular domain, after getting a response it is necessary to transform the domain of the urls returned by the api
from www.abebooks.com(default), to the domain you want (www.abebooks.de in the example above).

[1]: https://github.com/geemus/excon
[2]: https://github.com/sferik/multi_xml
[3]: http://www.abebooks.com/docs/AffiliateProgram/WebServices/end-user-guide.pdf
