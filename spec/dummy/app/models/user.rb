class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include ReTrack::Trackable
end
