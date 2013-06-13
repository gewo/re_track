# ReTrack

[![Build Status](https://travis-ci.org/gewo/re_track.png)](https://travis-ci.org/gewo/re_track/)

Track HTTP-Referrers in Rails using Mongoid.

## Installation

Add this line to your application's Gemfile:

    gem 're_track'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install re_track

## Usage

    ApplicationController
      # saves referer information to the session
      include ReTrack::Tracker
    end

    OtherController
      # put in the controllers which create the model you want to track
      cache_sweeper ReTrack::Sweeper
    end

    MyModel
      # include in every model that should get tracking information added
      include ReTrack::Trackable
    end

When your `OtherController` creates `MyModel` a
`ReTrack::RefererTracking` is created as well, access it like this:

    my_model.referer_tracking
    ReTrack::RefererTracking.all.distinct(:first_url)

## TODO

### Get rid of `ActionController::Caching::Sweeper`!

* right now ActiveRecord *and* Mongoid are required in your Rails app
* it works although Mongoid models are observed by `ActiveRecord::Observer`s...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credit

[re_track](http://github.com/gewo/re_track/) is inspired (read: stolen)
by [referer_tracking](http://github.com/holli/referer_tracking). Thanks.

## License

This project rocks and uses MIT-LICENSE.
