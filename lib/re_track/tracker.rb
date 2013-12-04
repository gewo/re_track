module ReTrack
  module Tracker
    extend ActiveSupport::Concern

    included do
      before_filter :rt_track_referer
    end

    private

      TRACK = {
        referer_url: ->(request) { request.headers['HTTP_REFERER'].presence || 'none' },
        first_url: ->(request) { request.url },
        user_agent: ->(request) { request.env['HTTP_USER_AGENT'] },
        first_visited_at: ->(request) { Time.now },
        ip: ->(request) { request.remote_ip },
        accept_language: ->(request) { request.env['HTTP_ACCEPT_LANGUAGE'] },
        forwarded_ip: ->(request) { request.env['HTTP_X_FORWARDED_FOR'] || request.env['HTTP_CLIENT_IP'] }
      }

      def rt_track_referer
        session[:retrack].nil? && !request_from_a_known_bot? &&
          session[:retrack] = Hash[TRACK.map { |k, v| [k, v.call(request)] }]
      end

      def request_from_a_known_bot?
        bot_user_agents = ['GoogleBot', 'Mediapartners-Google', 'msnbot',
          'TwengaBot', 'DigExt; DTS Agent', 'YandexImages']
        bot_user_agents_re = /\b(#{bot_user_agents * '|'})\b/i
        request.user_agent =~ bot_user_agents_re
      end
  end
end
