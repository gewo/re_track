module ReTrack
  class RefererTracking
    include ::Mongoid::Document
    include ::Mongoid::Timestamps

    store_in collection: 'retrack_referer_trackings'

    belongs_to :trackable, polymorphic: true, index: true

    field :referer_url,      type: String
    field :first_url,        type: String
    field :user_agent,       type: String
    field :first_visited_at, type: DateTime
    field :ip,               type: String
    field :forwarded_ip,     type: String
    field :accept_language,  type: String

    [:referer_url, :first_url, :user_agent, :first_visited_at, :ip,
     :forwarded_ip, :accept_language].each { |field| index({ field => 1 }) }

    # Extract query parameters from referer_url and first_url.
    #
    # @example
    #   r = ReTrack::RefererTracking.new first_url: 'http://google.de/?q=a'
    #   r.query('q')                 # => 'a'
    #   r.query('a')                 # => nil
    #   r.query('q', 'referer_url')  # => nil
    #
    # @param parameter [String] The Query String Parameter to look up.
    # @param url_field_name [String] The URL field to query. Either
    #   'referer_url' or 'first_url'.
    #
    # @return [String] The value for the given query parameter or nil.
    def query(parameter, url_field_name = 'first_url')
      return nil unless url = value_for(url_field_name)
      query_hash(url)[parameter.to_s]
    end

    private

      def query_hash(url)
        Rack::Utils.parse_query URI.parse(CGI::unescape(url)).query rescue {}
      end

      def value_for(field)
        return nil unless ['referer_url', 'first_url'].include? field.to_s
        public_send("#{field}")
      end
  end
end
