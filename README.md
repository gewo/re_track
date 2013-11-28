# ReTrack

[![Build Status](https://travis-ci.org/gewo/re_track.png)](https://travis-ci.org/gewo/re_track/)
[![Coverage Status](https://coveralls.io/repos/gewo/re_track/badge.png)](https://coveralls.io/r/gewo/re_track)
[![Code Climate](https://codeclimate.com/github/gewo/re_track.png)](https://codeclimate.com/github/gewo/re_track)
[![Dependency Status](https://gemnasium.com/gewo/re_track.png)](https://gemnasium.com/gewo/re_track)

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
      include ReTrack::Sweeper
      re_track :user # there has to be a trackable @user instance variable
    end

    MyModel
      # include in every model that should get tracking information added
      include ReTrack::Trackable
    end

When your `OtherController` creates `MyModel` in its `create`-action a
`ReTrack::RefererTracking` is created as well, access it like this:

    my_model.referer_tracking
    ReTrack::RefererTracking.all.distinct(:first_url)

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
