require 'active_support/concern'

module ReTrack
  module Trackable
    extend ActiveSupport::Concern

    included do
      has_one :referer_tracking,
        class_name: 'ReTrack::RefererTracking',
        as: :trackable,
        validate: false
    end
  end
end
