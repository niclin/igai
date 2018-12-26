# iGai 愛改

Facebook 的買賣社團太容易被朋友監視，無聊寫的玩具

## Requirements

- Ruby ~> 2.4
- PostgreSQL >= 9.4
- Redis
- [anycable-go](https://github.com/anycable/anycable-go)

## Setup

`$ cp config/database.example.yml config/database.yml`

run AnyCable RPC server:

```
$ bundle exec anycable
```

run AnyCable WebSocket server, e.g. [anycable-go](https://docs.anycable.io/#go_getting_started.md):

```
$ anycable-go --host=localhost --port=3334
```

Install node packages

```
$ yarn install
```

Seed task

```
$ rake create_categories:run
```

Start server

```
$ rails server
```


