# Picasa

Ruby library for Picasa Web Albums Data API

## Installation

```
gem install picasa
```

## Usage

``` ruby
client = Picasa::Client.new(:user_id => "google_username")
client.album.list
# => Picasa::Presenter::AlbumList

client.album.photos("album-id")
# => Picasa::Presenter::Album
```

## Continuous Integration
[![Build Status](https://secure.travis-ci.org/morgoth/picasa.png)](http://travis-ci.org/morgoth/picasa)

## Contributors

* [Bram Wijnands](https://github.com/BRamBoo)
* [Rafael Souza](https://github.com/rafaels)
* [jsaak](https://github.com/jsaak)
* [Javier Guerra](https://github.com/javierg)

## Copyright

Copyright (c) Wojciech Wnętrzak, released under the MIT license.
