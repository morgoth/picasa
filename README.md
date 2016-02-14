# Picasa

Ruby library for [Picasa Web Albums Data API](https://developers.google.com/picasa-web/)

Note: Picasa service will retire: [Moving on from Picasa](http://googlephotos.blogspot.com/2016/02/moving-on-from-picasa.html)

## Installation

```
gem install picasa
```

# Usage

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

## Authentication

When request is authenticated, response will contain private data, however this can be controlled by `access` parameter.

You can authenticate by specifing access_token:

```ruby
client = Picasa::Client.new(user_id: "some.user@gmail.com", access_token: "access-token")
```

As authenticating by providing password is no longer possible due to google API shutdown https://developers.google.com/accounts/docs/AuthForInstalledApps
you need to set `access_token` for authenticated requests.

### One time usage

For one time usage, you can retrieve access_token from google playground:
* Visit https://developers.google.com/oauthplayground
* Find "Picasa Web v2"
* Click "Authorize APIs" providing your credentials
* Click "Exchange authorization code for tokens"
* Copy `access_token` value

OAuth2 integration is not yet supported in this gem.

### Permanent server side usage

* Go to https://console.developers.google.com
* Register an account and create project
* On "APIs & auth > Credentials" click "Create new Client ID"
* Choose "Installed application > Other"
* Note "Client ID" and "Client secret"
* Craft URL replacing `YOUR_CLIENT_ID` `https://accounts.google.com/o/oauth2/auth?scope=http://picasaweb.google.com/data/&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id=YOUR_CLIENT_ID`
* Visit URL, grant access to your account and note `code`
* Install gem `signet`
* One time setup, to fetch `refresh_token`
```ruby
client_id = "client-id"
client_secret = "client-secret"
code = "authorization-code"

require "signet/oauth_2/client"
signet = Signet::OAuth2::Client.new(
  code: code,
  token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
  client_id: client_id,
  client_secret: client_secret,
  redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
)
signet.fetch_access_token!
signet.refresh_token
```
* Note `refresh_token`
* Before gem usage, you can get `access_token` by:
```ruby
require "signet/oauth_2/client"
signet = Signet::OAuth2::Client.new(
  client_id: client_id,
  client_secret: client_secret,
  token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
  refresh_token: refresh_token
)
signet.refresh!

# Use access token with picasa gem
signet.access_token
```

## Proxy

You can connect via proxy server setting `https_proxy` or `HTTPS_PROXY` environment variable to valid URL.

## Extra

You can install thor script for uploading all photos and videos from given directory:

```
thor install https://github.com/morgoth/picasa/raw/master/extra/Thorfile --as imagery --force
```

Updating script can be done by:

```
thor update imagery
```

And then use it (it will create album taking title from folder name and upload all photos from that directory):

```
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_ACCESS_TOKEN=access-token thor imagery:upload path-to-folder-with-photos
```

If your upload was somehow interrupted, you can resume it by adding `--continue` option:

```
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_ACCESS_TOKEN=access-token thor imagery:upload --continue path-to-folder-with-photos
```

If you run out of quota and want to resize images to fit Picasa free storage limits, you can install `rmagick` gem and run (this will modify files):

```
thor imagery:resize path-to-folder-with-photos
```

## Boost

Picasa uses gzipped requests to speedup fetching results. Benchmarks are available on [Vinicius Teles gist](https://gist.github.com/4012466)

## Continuous Integration
[![Build Status](https://secure.travis-ci.org/morgoth/picasa.png)](http://travis-ci.org/morgoth/picasa)

## Contributors

* [Bram Wijnands](https://github.com/Bram--)
* [Rafael Souza](https://github.com/rafaels)
* [jsaak](https://github.com/jsaak)
* [Javier Guerra](https://github.com/javierg)
* [Eiichi Takebuchi](https://github.com/GRGSIBERIA)
* [TADA Tadashi](https://github.com/tdtds)
* [Vinicius Teles](https://github.com/viniciusteles)
* [Ionut-Cristian Florescu](https://github.com/icflorescu)
* [Sébastien Grosjean](https://github.com/ZenCocoon)
* [Grant Gardner](https://github.com/lwoggardner)
* [Anton Astashov](https://github.com/astashov)
* [Ojash Dahal](https://github.com/ojash)
* [johnf](https://github.com/johnf)

## Copyright

Copyright (c) Wojciech Wnętrzak, released under the MIT license.
