module ReTrack
  class RefererTracking
    include ::Mongoid::Document
    include ::Mongoid::Timestamps

    store_in collection: 'retrack_referer_trackings'

    belongs_to :trackable, polymorphic: true

    field :referer_url,      type: String
    field :first_url,        type: String
    field :user_agent,       type: String
    field :first_visited_at, type: DateTime
  end
end
