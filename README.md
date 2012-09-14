# Picasa

Ruby library for [Picasa Web Albums Data API](https://developers.google.com/picasa-web/)

## Installation

```
gem install picasa
```

## Usage

[Documentation](http://rubydoc.info/github/morgoth/picasa)

``` ruby
client = Picasa::Client.new(user_id: "username@gmail.com")
client.album.list
# => Picasa::Presenter::AlbumList

client.album.show("album_id")
# => Picasa::Presenter::Album
```

If password is specified, all requests will be authenticated.
This affect results to contain private data.

## Extra

You can install thor script for uploading all photos from given directory:

```
thor install https://github.com/morgoth/picasa/raw/master/extra/Thorfile --as picasa_uploader --force
```

And then use it:

```
thor picasa_uploader:upload_all path-to-folder-with-photos
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
