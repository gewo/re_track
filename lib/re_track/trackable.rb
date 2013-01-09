require 'active_support/concern'

module ReTrack
  module Trackable
    extend ActiveSupport::Concern

    included do
      has_one :referer_tracking,
        class_name: 'ReTrack::RefererTracking',
        as: :trackable

      klass = self
      ReTrack::Sweeper.class_eval do
        observe klass
      end
    end
  end
end
