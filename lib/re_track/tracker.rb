module ReTrack
  module Tracker
    extend ActiveSupport::Concern

    included do
      before_filter :rt_track_referer
    end

    def rt_track_referer
      if session[:retrack].nil? && !request_from_a_known_bot?
        session[:retrack] = hash = {}
        hash[:referer_url] = request.headers['HTTP_REFERER'].presence || 'none'
        hash[:first_url] = request.url
        hash[:user_agent] = request.env['HTTP_USER_AGENT']
        hash[:first_visited_at] = Time.now
        hash[:ip] = request.remote_ip
        hash[:forwarded_ip] = request.env['HTTP_X_FORWARDED_FOR'] ||
          request.env['HTTP_CLIENT_IP']
        hash[:accept_language] = request.env['HTTP_ACCEPT_LANGUAGE']
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
