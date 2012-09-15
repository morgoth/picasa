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

client.photo.create("album_id", file_path: "path/to/my-photo.png")
# => Picasa::Presenter::Photo
```

If password is specified, all requests will be authenticated.
This affect results to contain private data, however it can be controlled by `access` parameter.

## Caveats

Currently picasa wont work with `ox` xml parser.
Using `rexml` parser wont return `etag` attribute properly.
I recommend to use `libxml` or `nokogiri`.

## Extra

You can install thor script for uploading all photos from given directory:

```
thor install https://github.com/morgoth/picasa/raw/master/extra/Thorfile --as picasa_uploader --force
```

Updating script can be done by:

```
thor update picasa_uploader
```

And then use it (it will create album taking title from folder name and upload all photos from that directory):

```
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_PASSWORD=secret thor picasa_uploader:upload_all path-to-folder-with-photos
```

If your upload was somehow interrupted, you can resume it by adding `--continue` option:

```
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_PASSWORD=secret thor picasa_uploader:upload_all --continue path-to-folder-with-photos
```

## Continuous Integration
[![Build Status](https://secure.travis-ci.org/morgoth/picasa.png)](http://travis-ci.org/morgoth/picasa)

## Contributors

* [Bram Wijnands](https://github.com/Bram--)
* [Rafael Souza](https://github.com/rafaels)
* [jsaak](https://github.com/jsaak)
* [Javier Guerra](https://github.com/javierg)
* [Eiichi Takebuchi](https://github.com/GRGSIBERIA)

## Copyright

Copyright (c) Wojciech Wnętrzak, released under the MIT license.
