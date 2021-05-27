# Abebooks

**Abebooks** is a Ruby wrapper to the [Abebooks SWS API][1].

## Usage

Create a request:

```ruby
req = Abebooks.new(client_key)
```

Run a query and parse response into a Ruby Hash:

```ruby
response = request.get(author: 'Tolkien')
response.to_h
```

Or pass the response into a custom parser:

```ruby
MyParser.new(res.to_s)
```

[1]: https://www.abebooks.com/docs/AffiliateProgram/WebServices/end-user-guide.pdf
