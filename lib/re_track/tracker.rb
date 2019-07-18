module ReTrack
  module Tracker
    extend ActiveSupport::Concern

    included do
      before_action :rt_track_referer
    end

    private

      def rt_track_referer
        session[:retrack].nil? && !request_from_a_known_bot? &&
          session[:retrack] = SessionData.to_hash(request)
      end

      def request_from_a_known_bot?
        bot_user_agents = ['GoogleBot', 'Mediapartners-Google', 'msnbot',
          'TwengaBot', 'DigExt; DTS Agent', 'YandexImages']
        bot_user_agents_re = /\b(#{bot_user_agents * '|'})\b/i
        request.user_agent =~ bot_user_agents_re
      end
  end
end
