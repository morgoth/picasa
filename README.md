# Picasa

Ruby libraroy for Picasa Web Albums Data API
Only for public albums so far.

## Installation

```
gem install picasa
```

## Usage

``` ruby
Picasa.albums(:google_user => "google_username")
# => [ {:id => "666", :title => "satan-album", :photos_count => 6, :photo => "url",
#      :thumbnail => "url", :slideshow => "url", :summary => "summary"},
#     {another one} ]

Picasa.photos(:google_user => "google_username", :album_id => "album_id")
#=> {:photos => [{ :title, :thumbnail_1, :thumbnail_2, :thumbnail_3, :photo },{}],
#    :slideshow => "link to picasa slideshow"}
```

or you can set google user for all requests like this:

``` ruby
Picasa.configure do |config|
  config.user_id = "john.doe"
end
```

and use it:

``` ruby
Picasa.albums
Picasa.photos(:album_id => "album_id")
```

## Continuous Integration
[![Build Status](https://secure.travis-ci.org/morgoth/picasa.png)](http://travis-ci.org/morgoth/picasa)

## Copyright

Copyright (c) 2011 Wojciech Wnętrzak, released under the MIT license.
