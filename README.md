### Purpose
Sample API Enpoint Server

1. Provides a simple API server (no database required)
2. Returns HTML or JSON based on headers or path

### Quickstart

1.  `bundle install`
2.  `shotgun config.ru`

Hit any of these paths:

```
GET '/contacts'
GET '/contacts/json'
GET '/contacts/1'
GET '/contacts/1/json'
```
