# FinAPI Client

Oh FinAPI, even though swagger may seem like a good idea, the generated
client is not.. at least not for ruby.

This is an attempt to shed a little light into the chaos and
reimplement the client in ruby like fashion. The design is heavily
inspired by Ismael Celis' [Writing a Hypermedia Client in
Ruby](https://robots.thoughtbot.com/writing-a-hypermedia-api-client-in-ruby).
Thanks for the article!

# Supported End Points

GET /transactions/{id}
GET /transactions
