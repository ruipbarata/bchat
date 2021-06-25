# bChat

https://barata-chat.herokuapp.com/
#### Dependencies
-   [Ruby  _3.0.0_](https://www.ruby-lang.org/en/documentation/installation/)
-   [Rails  _6.1.3_](http://rubyonrails.org/)
-   [PostgreSQL  _13.1_](https://www.postgresql.org/)

**Important**

Don"t forget to follow the  `.env_example`  to build your  `.env`.

#### Start the server

```bash
rails s (default port number: 3000)
rails s -p <port number>
```


Try it:

```bash
curl localhost:3000
```

#### Tests

    bundle exec rspec spec/<path to file>_spec.rb (run a spec)
    ./bin/test (run the test suite)

**Important**

The test suite script needs to have execution permission. To give it use this:
```bash
$ chmod +x bin/test
```
