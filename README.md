# Abebooks

**Abebooks** is a Ruby wrapper to the [Abebooks SWS API][1].

## Usage

Create a request:

```ruby
req = Abebooks.new(client_key)
```

Run a query:

```ruby
params = { author: 'Foucault' }
res = req.get(query: params)
```

Parse the response into a Ruby Hash:

```ruby
res.to_h
```

Or pass its body into a custom parser:

```ruby
MyParser.new(res.body)
```

[1]: http://www.abebooks.com/docs/AffiliateProgram/WebServices/end-user-guide.pdf
