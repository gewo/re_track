module ReTrack
  module SessionData
    ATTRIBUTES = [
      :referer_url, :first_url, :user_agent, :first_visited_at, :ip,
      :accept_language, :forwarded_ip
    ]

    def to_hash(request)
      @request = request
      Hash[ATTRIBUTES.map { |k, v| [k, send(k)] }]
    end

    private

      def referer_url
        @request.headers['HTTP_REFERER'].presence || 'none'
      end

      def first_url
        @request.url
      end

      def user_agent
        @request.env['HTTP_USER_AGENT']
      end

      def first_visited_at
        Time.now
      end

      def ip
        @request.remote_ip
      end

      def accept_language
        @request.env['HTTP_ACCEPT_LANGUAGE']
      end

      def forwarded_ip
        @request.env['HTTP_X_FORWARDED_FOR'] || @request.env['HTTP_CLIENT_IP']
      end

    extend self
  end
end
