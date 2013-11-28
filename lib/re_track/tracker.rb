module ReTrack
  module Tracker
    extend ActiveSupport::Concern

    included do
      before_filter :rt_track_referer
    end

    def rt_track_referer
      if session[:retrack].nil? && !request_from_a_known_bot?
        session[:retrack] = Hash[
          :referer_url,      request.headers['HTTP_REFERER'].presence || 'none',
          :first_url,        request.url,
          :user_agent,       request.env['HTTP_USER_AGENT'],
          :first_visited_at, Time.now,
          :ip,               request.remote_ip,
          :accept_language,  request.env['HTTP_ACCEPT_LANGUAGE'],
          :forwarded_ip,     request.env['HTTP_X_FORWARDED_FOR'] || request.env['HTTP_CLIENT_IP']
        ]
      end
    end

    def request_from_a_known_bot?
      bot_user_agents = ['GoogleBot', 'Mediapartners-Google', 'msnbot',
        'TwengaBot', 'DigExt; DTS Agent', 'YandexImages']
      bot_user_agents_re = /\b(#{bot_user_agents * '|'})\b/i
      request.user_agent =~ bot_user_agents_re
    end
  end
end
